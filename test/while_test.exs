ExUnit.start()
Code.require_file("../lib/while_ex2.ex", __DIR__)

defmodule WhileTest do
  use ExUnit.Case

  import WhileEx2

  test "Is it really that easy?" do
    assert Code.ensure_loaded?(WhileEx2)
  end

  test "while/2 loops as long as the expression is truthy" do
    pid = spawn(fn -> :timer.sleep(:infinity) end)

    send(self(), :one)

    while Process.alive?(pid) do
      receive do
        :one ->
          send(self(), :two)

        :two ->
          send(self(), :three)

        :three ->
          Process.exit(pid, :kill)
          IO.puts("is Process #{inspect(pid)}alive #{Process.alive?(pid)}")
          send(self(), :done)
      end

      IO.puts("is Process #{inspect(pid)}alive #{Process.alive?(pid)}")
    end

    assert_received :done
  end

  test "break/0 terminates execution" do
    send(self(), :one)

    while true do
      receive do
        :one ->
          send(self(), :two)

        :two ->
          send(self(), :three)

        :three ->
          send(self(), :done)
          break
      end
    end

    assert_received :done
  end
end

# mix test test/while_test.exs
#
# OR
#
# elixir test/while_test.exs  -- possible because we are reuiring file first and starting ExUnit, other wise it will not compile or throw error in case WhileEx2 Module not loaded properly.
#
