# Will generate error
# defmodule General.MacroExcapeIncorrect do
#   map = %{name: "Navneet"}
#
#   def value do
#     unquote(map)
#   end
# end

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
