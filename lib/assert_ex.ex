defmodule AssertEx do
  defmacro assert({operation, _, [lhs, rhs]}) do
    quote bind_quoted: [operation: operation, lhs: lhs, rhs: rhs] do
      AssertEx.Test.assert(operation, lhs, rhs)
    end
  end
end

defmodule AssertEx.Test do
  def assert(:==, lhs, rhs) when lhs == rhs do
    IO.puts(".")
  end

  def assert(:==, lhs, rhs) do
    IO.puts("""
    Failure:
    Expected:     #{lhs}
    to be equal to #{rhs}
    """)
  end

  def assert(:>, lhs, rhs) when lhs > rhs do
    IO.puts(".")
  end

  def assert(:>, lhs, rhs) do
    IO.puts("""
    Failure:
    Expected:     #{lhs}
    to be greater than #{rhs}
    """)
  end

  def assert(:>=, lhs, rhs) when lhs >= rhs do
    IO.puts(".")
  end

  def assert(:>=, lhs, rhs) do
    IO.puts("""
    Failure:
    Expected:     #{lhs}
    to be greater than/ equal to #{rhs}
    """)
  end

  def assert(:<, lhs, rhs) when lhs < rhs do
    IO.puts(".")
  end

  def assert(:<, lhs, rhs) do
    IO.puts("""
    Failure:
    Expected:     #{lhs}
    to be lesser than #{rhs}
    """)
  end

  def assert(:<=, lhs, rhs) when lhs <= rhs do
    IO.puts(".")
  end

  def assert(:<=, lhs, rhs) do
    IO.puts("""
    Failure:
    Expected:     #{lhs}
    to be lesser than / equal to #{rhs}
    """)
  end
end
