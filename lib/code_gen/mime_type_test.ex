defmodule CodeGen.MimeTypeTest do
  use CodeGen.MimiType,
    "text/emoji": [".emj"],
    "text/elixir": [".exs"]

  def test do
    IO.puts("testing CodeGen.CodeGen.MimeTypeTest")
  end
end

# iex -S mix
# iex(1)> CodeGen.MimeTypeTest.type_from_ext(".exs")
# :"text/elixir"
# iex(2)> CodeGen.MimeTypeTest.exts_from_type("text/elixir")
# [".exs"]
