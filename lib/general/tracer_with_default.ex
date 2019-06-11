defmodule General.TracerWithDefault do
  defmacro deftrace(func_head, func_body) do
    IO.puts("@@@@@@@@@@ #{inspect(func_head)}")
    IO.puts("@@@@@@@@@@ #{inspect(func_body)}")
    {name_ast, args_ast} = name_with_args(func_head)
    {arg_names, decorated_args} = decorate_args(args_ast)
    IO.puts("@@@@@@@@@@name_ast==== #{inspect(name_ast)}")
    IO.puts("@@@@@@@@@@args_ast==== #{inspect(args_ast)}")
    IO.puts("@@@@@@@@@@arg_names==== #{inspect(arg_names)}")
    IO.puts("@@@@@@@@@@decorated_args==== #{inspect(decorated_args)}")

    func_head =
      Macro.postwalk(
        func_head,
        fn
          {fun_name_ast, context, fun_arg_ast}
          when fun_name_ast == name_ast and fun_arg_ast == args_ast ->
            {fun_name_ast, context, decorated_args}

          other ->
            other
        end
      )

    quote do
      def unquote(func_head) do
        file = __ENV__.file
        line = __ENV__.line
        module = __ENV__.module
        fun_name = unquote(name_ast)
        passed_args = unquote(arg_names) |> Enum.map(&IO.inspect(&1)) |> Enum.join(",")
        result = unquote(func_body[:do])

        loc = "#{file}(line #{line})"
        call = "#{module}.#{fun_name}(#{passed_args}) = #{inspect(result)}"
        IO.puts("#{loc} #{call}")
        result
      end
    end
  end

  defp name_with_args({:when, _, [func_head | _]}) do
    IO.puts("====name_with_args/2==== #{inspect(func_head)}")
    name_with_args(func_head)
  end

  defp name_with_args(func_head) do
    IO.puts("=====name_with_args/1=== #{inspect(func_head)}")
    Macro.decompose_call(func_head)
  end

  defp decorate_args([]), do: {[], []}

  defp decorate_args(args_ast) do
    IO.puts("====decorate_args==== #{inspect(args_ast)}")

    args_ast
    |> Enum.with_index()
    |> Enum.map(&decorate(&1))
    |> Enum.unzip()
  end

  defp decorate({arg_ast, index}) do
    case arg_ast do
      {:\\, _, [{optional_name, _, _}, _default_value]} ->
        {Macro.var(optional_name, nil), arg_ast}

      _ ->
        arg_name = Macro.var(:"arg#{index}", __MODULE__)

        full_arg =
          quote do
            unquote(arg_ast) = unquote(arg_name)
          end

        {arg_name, full_arg}
    end
  end
end
