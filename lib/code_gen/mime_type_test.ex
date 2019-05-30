defmodule CodeGen.MimeTypeTest do
  use CodeGen.MimiType,
    "text/emoji": [".emj"],
    "text/elixir": [".exs"]

  def test do
    IO.puts("testing CodeGen.CodeGen.MimeTypeTest")
  end
end
