defmodule QuoteUnquote do
  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)
      alias unquote(__MODULE__)
    end
  end
end
