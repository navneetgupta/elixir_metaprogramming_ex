# Will generate error
# defmodule General.MacroExcapeIncorrect do
#   map = %{name: "Navneet"}
#
#   def value do
#     unquote(map)
#   end
# end

# Macro.escape is used to take an Elixir literal and recursively escape it for injection into an AST. Its use is required when you need to inject an Elixir value into an already-quoted expression where the value is not an AST literal. 
defmodule General.MacroExcapeCorrect do
  map = Macro.escape(%{name: "Navneet"})

  def value do
    unquote(map)
  end
end

defmodule General.MacroEscapeCorrect2 do
  # map = Macro.escape(%{name: "Navneet"})

  def value do
    unquote(quote do: %{name: "Navneet"})
  end
end
