defmodule AssertTests.MathTest do
  import AssertEx

  def run do
    assert 5 == 5
    assert 10 > 0
    assert 1 > 2
    assert 10 * 10 == 100
  end
end

# iex -S mix
# iex> AssertTests.MathTest.run
