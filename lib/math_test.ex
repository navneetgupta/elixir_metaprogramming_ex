defmodule MathTest do
  defmacro say({:+, _, [lhs, rhs]}) do
    quote do
      lhs = unquote(lhs)
      rhs = unquote(rhs)
      sum = lhs + rhs
      IO.puts("#{lhs} plus #{rhs} is #{sum}")
    end
  end

  defmacro say({:*, _, [lhs, rhs]}) do
    quote do
      lhs = unquote(lhs)
      rhs = unquote(rhs)
      product = lhs * rhs
      IO.puts("#{lhs} multiplied by #{rhs} results to #{product}")
    end
  end
end

# iex -S mix
# iex(1)> require MathTest
# iex(2)> MathTest.say 5 + 8
# iex(3)> MathTest.say 5 * 8
# iex(6)> MathTest.say 5 * 8 + 2 + 2
# iex(5)> MathTest.say 5 * 8 + 2 * 2
# iex(4)> MathTest.say 5 * 8 + 2
