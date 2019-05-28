defmodule CodeGen.MimiType do
  @external_resource mime_file = Path.join([__DIR__, "mimes.txt"])

  for line <- File.stream!(mime_file, [], :line) do
    [type, rest] =
      line
      |> String.split("\t")
      |> Enum.map(&String.trim(&1))

    extensions = String.split(rest, ~r/,\s?/)
    def exts_from_type(unquote(type)), do: unquote(extensions)
    def type_from_ext(ext) when ext in unquote(extensions), do: unquote(type)
  end

  def exts_from_type(_type), do: []
  def type_from_ext(_ext), do: nil
  def valid_type?(type), do: exts_from_type(type) |> Enum.any?()
end

# iex -S mix
# iex(1)> CodeGen.MimiType.exts_from_type("image/jpeg")
# [".jpeg", ".jpg"]
# iex(2)> CodeGen.MimiType.type_from_ext(".jpg")
# "image/jpeg"
# iex(3)> CodeGen.MimiType.type_from_ext(".jpeg")
# "image/jpeg"
# iex(4)> CodeGen.MimiType.valid_type?("text/html")
# true
# iex(5)> CodeGen.MimiType.valid_type?("text/html1")
# false
# iex(6)> CodeGen.MimiType.valid_type?("text/emoji")
# false
