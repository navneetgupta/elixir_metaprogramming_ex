defmodule General.GeneralisedAST do
end

# AST for variable
# iex(1)> quote do my_var end
# {:my_var, [], Elixir}  -- generalised {variable_name, context, module_where_the_quoting_happened}

# Here, the first element represents the name of the variable
# The third element usually represents the module where the quoting happened, and is used to ensure hygiene of quoted variables. If this element is nil then the identifier is not hygienic.

# AST for simple expression
# iex(2)> quote do a+b end
# {:+, [context: Elixir, import: Kernel], [{:a, [], Elixir}, {:b, [], Elixir}]}
# Generalised: {function, context, arguments_to_function} => {:+, context, [ast_for_a, ast_for_b]}
#
# ast_for_a and ast_for_b follow the shape of a variable reference

# AST for function call
# iex(2)> quote do div(3,2) end
# {:div, [context: Elixir, import: Kernel], [3, 2]}

# AST for function definition
# iex(4)> quote do def my_fun(arg1, arg2), do: :ok end
# {:def, [context: Elixir, import: Kernel],
#  [{:my_fun, [context: Elixir], [{:arg1, [], Elixir}, {:arg2, [], Elixir}]},
# [do: :ok]]}
# Generalised: {:def, context, [fun_call, [do: body]]} -- where fun_call as described above `#AST for function call`
