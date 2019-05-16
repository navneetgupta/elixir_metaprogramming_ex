defmodule UnlessMacro2 do
  defmacro unless(expr, do: block) do
    quote do
      if !unquote(expr), do: unquote(block)
    end
  end

  # when ever we see unless(expr, do: block) replace with "if !evaluate(expr), do: evaluate(block)"
end

# Using:
# iex> require UnlessMacro2
# iex> UnlessMacro2.unless true, do: "Hello There" 
