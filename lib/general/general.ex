defmodule General do
end

# Evaluating a Quoted Expression.
# iex(1)> quoted = quote do 1 + 2 end
# iex(2)> Code.eval_quoted(quoted)
# {3, []}
# The result tuple contains the result of the expression, and the list of variable bindings that are made in that expression.
#
# the quoted expression is not semantically verified. For example, when we write following expression:
# iex(3)> a + b
# ** (RuntimeError) undefined function: a/0
# But
# iex(4)> quote do a + b end
# {:+, [context: Elixir, import: Kernel], [{:a, [], Elixir}, {:b, [], Elixir}]}
# returns no error.There’s no error. We have a quoted representation of a+b, which means we generated the term that describes the expression a+b, regardless of whether these variables exist or not. The final code is not yet emitted, so there’s no error.

# If we insert that representation into some part of the AST where a and b are valid identifiers, this code will be correct.
# iex(5)> sum_expr = quote do a + b end
# iex(6)> bind_expr = quote do
#   a=1
#   b=2
# end
# iex(6)> final_expr = quote do
#   unquote(bind_expr)
#   unquote(sum_expr)
# end
# iex(7)> Code.eval_quoted(final_expr)
# {3, [{{:a, Elixir}, 1}, {{:b, Elixir},
# unquote(...) - the expression inside parentheses is immediately evaluated, and inserted in place of the unquote call. This in turn means that the result of unquote must also be a valid AST fragment.
