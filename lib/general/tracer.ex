defmodule General.Tracer do
  defmacro trace(expression_ast) do
    string_representation = Macro.to_string(expression_ast)

    quote do
      result = unquote(expression_ast)
      General.Tracer.print(unquote(string_representation), result)
      result
    end
  end

  def print(string_representation, result) do
    IO.puts("Result of #{string_representation}: #{inspect(result)}")
  end

  defmacro deftraceable(func_head, func_body) do
    {fun_name_ast, fun_args_ast} = Macro.decompose_call(func_head)
    IO.inspect(fun_name_ast)
    IO.inspect(fun_args_ast)
    IO.inspect(func_head)
    IO.inspect(func_body)

    quote do
      def unquote(func_head) do
        file = __ENV__.file
        line = __ENV__.line
        module = __ENV__.module
        fun_name = unquote(fun_name_ast)
        passed_args = unquote(fun_args_ast) |> Enum.map(&IO.inspect(&1)) |> Enum.join(",")

        result = unquote(func_body[:do])

        loc = "#{file}(line #{line})"
        call = "#{module}.#{fun_name}(#{passed_args}) = #{inspect(result)}"
        IO.puts("#{loc} #{call}")

        result
      end
    end
  end
end

# Our macro receives a quoted expression. This is very important to keep in mind - whichever arguments you send to a macro, they will already be quoted. So when we call Tracer.trace(1+2), our macro (which is a function) won’t receive 3. Instead, the contents of expression_ast will be the result of quote(do: 1+2).
#
# iex> require Tracer
# iex> quoted = quote do Tracer.trace(1+2) end
# {{:., [], [{:__aliases__, [alias: false], [:Tracer]}, :trace]}, [],
# [{:+, [context: Elixir, import: Kernel], [1, 2]}]}
# Now, we can turn this AST into an expanded version, using Macro.expand/2:
# iex> expanded = Macro.expand(quoted, __ENV__)
# {:__block__, [],
# [{:=, [],
#   [{:result, [counter: 5], Tracer},
#    {:+, [context: Elixir, import: Kernel], [1, 2]}]},
#  {{:., [], [{:__aliases__, [alias: false, counter: 5], [:Tracer]}, :print]},
#   [], ["1 + 2", {:result, [counter: 5], Tracer}]},
#  {:result, [counter: 5], Tracer}]}
#   You can even turn this expression into a string:
#   iex> Macro.to_string(expanded) |> IO.puts
