defmodule General.TracerWithGuard do
  defmacro deftraceable(func_head, func_body) do
    {fun_name_ast, fun_args_ast} = name_and_args_ast(func_head)

    {args_name, decorated_args} = decorate_args(fun_args_ast)
    IO.puts("====fun_name_ast==== #{inspect(fun_name_ast)}")
    IO.puts("====fun_args_ast==== #{inspect(fun_args_ast)}")
    IO.puts("====args_name==== #{inspect(args_name)}")
    IO.puts("====decorated_args==== #{inspect(decorated_args)}")

    func_head =
      Macro.postwalk(
        func_head,
        fn
          {fun_ast, context, args_ast}
          when fun_ast == fun_name_ast and args_ast == fun_args_ast ->
            {fun_ast, context, decorated_args}

          other ->
            other
        end
      )

    quote do
      def unquote(func_head) do
        file = __ENV__.file
        line = __ENV__.line
        module = __ENV__.module
        fun_name = unquote(fun_name_ast)
        # IO.puts "=============args_name #{inspect unquote(args_name)}"

        passed_args = unquote(args_name) |> Enum.map(&IO.inspect(&1)) |> Enum.join(",")

        result = unquote(func_body[:do])

        loc = "#{file}(line #{line})"
        call = "#{module}.#{fun_name}(#{passed_args}) = #{inspect(result)}"
        IO.puts("#{loc} #{call}")

        result
      end
    end

    # nil
  end

  defp name_and_args_ast({:when, _, [func_head | _tail]}) do
    name_and_args_ast(func_head)
  end

  defp name_and_args_ast(func_head) do
    Macro.decompose_call(func_head)
  end

  defp decorate_args(args_ast) do
    for {arg_ast, index} <- Enum.with_index(args_ast) do
      # Dynamically generate quoted identifier
      arg_name = Macro.var(:"arg#{index}", __MODULE__)

      # Generate AST for patternX = argX
      full_arg =
        quote do
          unquote(arg_ast) = unquote(arg_name)
        end

      {arg_name, full_arg}
    end
    |> Enum.unzip()
  end
end
