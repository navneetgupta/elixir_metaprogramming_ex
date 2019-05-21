defmodule UnlessMacro3 do
  defmacro unless(expr, do: block) do
    quote do
      case unquote(expr) do
        false -> unquote(block)
        _ -> nil
      end
    end
  end

  # when ever we see unless(expr, do: block) replace with "if !evaluate(expr), do: evaluate(block)"
end

# Using:
# iex> require UnlessMacro3
# iex> UnlessMacro2.unless true, do: "Hello There"
