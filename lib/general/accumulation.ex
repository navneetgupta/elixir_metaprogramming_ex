defmodule General.Accumulation do
  Module.register_attribute(__MODULE__, :chest, accumulate: true)

  @chest "bow"
  @chest "sword"
  def print_value do
    IO.inspect(@chest)
  end
end
