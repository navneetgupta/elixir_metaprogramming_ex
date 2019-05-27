defmodule General.Context do
  defmacro test_context do
    IO.puts("Current macro's Context: (#{inspect(__MODULE__)})")

    quote do
      IO.puts("Calle's Context: (#{inspect(__MODULE__)})")
      IO.puts("Getting Macro's Context: (#{inspect(unquote(__MODULE__))})")
    end
  end
end

defmodule General.Context.Test do
  require General.Context

  General.Context.test_context()
end

# iex -S mix
# iex(1)> General.Context.Test.text_context()
