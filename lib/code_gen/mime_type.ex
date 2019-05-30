defmodule CodeGen.MimiType do
  defmacro __using__(opts) do
    quote do
      IO.puts("options provided: #{inspect(unquote(opts))}")
      IO.puts("__MODULE__ : #{inspect(__MODULE__)}")
      IO.puts("unquote(__MODULE__): #{inspect(unquote(__MODULE__))}")
      # import unquote(__MODULE__)

      # opts
      # |> IO.inspect()
      # |> Keyword.keys()
      # |> IO.inspect()
      # |> Enum.each(fn x ->
      #   def exts_from_type(unquote(x)), do: IO.inspect(unquote(x))
      # end)

      # "Options Provided : #{inspect opts}"

      def run, do: IO.puts("test")
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      IO.puts("__MODULE__ : #{inspect(__MODULE__)}")
      IO.puts("unquote(__MODULE__): #{inspect(unquote(__MODULE__))}")
      import unquote(__MODULE__)
    end
  end

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

  # defguardp is_in_list(key, list) when key in list
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
