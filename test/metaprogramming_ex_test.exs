defmodule MetaprogrammingExTest do
  use ExUnit.Case
  doctest MetaprogrammingEx

  test "greets the world" do
    assert MetaprogrammingEx.hello() == :world
  end
end
