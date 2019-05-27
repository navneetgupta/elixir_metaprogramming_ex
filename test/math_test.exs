defmodule Test.MathTest do
  require AssertEx
  use ExUnit.Case

  test "run asset's tests" do
    AssertEx.assert(5 == 5)
    AssertEx.assert(10 > 0)
    AssertEx.assert(1 > 2)
    AssertEx.assert(10 * 10 == 100)
  end
end
