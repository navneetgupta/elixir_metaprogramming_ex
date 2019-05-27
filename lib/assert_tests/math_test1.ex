defmodule AssertTests.MathTest1 do
  use AssertTests.AssertionUpdated

  test "integers can be added and subtracted" do
    assert 1 + 1 == 2
    assert 2 + 3 == 5
    assert 5 - 5 == 10
  end

  test "integers can be multiplied and divided" do
    assert 5 * 5 == 25
    assert 10 / 2 == 5
    assert 10 / 5 == 3
  end
end
