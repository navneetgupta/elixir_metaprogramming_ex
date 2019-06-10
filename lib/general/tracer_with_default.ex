defmodule General.TracerWithDefault do
  defmacro deftraceable(func_head, func_body) do
    {name_ast, args_ast} = name_with_args(func_head)
    {arg_names, decorated_args} = decorate_args(args_ast)

    func_head =
      Macro.postwalk(func_head,
        fn ({fun_name_ast,context, fun_arg_ast}) when fun_name_ast == name_ast and fun_arg_ast == args_ast ->
          {fun_name_ast, context, decorated_args}
        (other) -> other
      end
      )

    quote do
      def unquote(func_head) do
        line = __ENV__.line
        file = __ENV__.file

        func_name = unquote(name_ast)
        presented_args  = unquote(arg_names) |> Enum.map(&inspect(&1)) |> Enum.join(",")

        result = unquote(func_body[:do])

        loc = "#{file}(line #{line})"
        call = "#{module}.#{fun_name}(#{passed_args}) = #{inspect(result)}"
        IO.puts("#{loc} #{call}")

        result
      end
    end
    nil
  end

  defp name_with_args({:when, _, [func_head | _]}) do
    name_with_args(func_head)
  end

  defp name_with_args(func_head) do
    Macro.decompose_call(func_head)
  end

  defp decorate_args(args_ast) do
    for {arg_ast, index} <- Enum.with_index(args_ast) do
      arg_name = Macro.var(:"arg#{index}", __MODULE__)

      full_arg = quote do
        unquote(arg_ast) = unquote(arg_name)
      end
      {arg_name, full_arg}
    end
    |> Enum.unzip
  end
end
