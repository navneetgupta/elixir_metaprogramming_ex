defmodule General.UnquoteFragments do
  # You might be wondering how we were able to call unquote outside of a quote block when defining our generated functions. Elixir supports the idea of unquote fragments. Unquote fragments allow you to create functions dynamically, like we did in our for comprehension above.
  # We used unquote fragments to define multiple heads of the exts_from_type and type_from_ext functions, but we can also use them to define function names on the fly.
  # for line <- File.stream!(Path.join([__DIR__, "mimes.txt"]), [], :line) do
  #   [type, rest] =
  #     line
  #     |> String.split("\t")
  #     |> Enum.map(&String.trim(&1))
  #
  #   extensions = String.split(rest, ~r/,\s?/)
  #   def exts_from_type(unquote(type)), do: unquote(extensions)
  #   def type_from_ext(ext) when ext in unquote(extensions), do: unquote(type)
  # end
  #
  # def exts_from_type(_type), do: []
  # def type_from_ext(_ext), do: nil
  # def valid_type?(type), do: exts_from_type(type) |> Enum.any?()
end

defmodule General.UnquoteFragments2 do
  for {name, val} <- [one: 1, two: 2, three: 3] do
    def unquote(name)(), do: unquote(val)
  end

  # this will create functions like
  # def one, do: 1
  # def two, do: 2
  # def three, do: 3
  #
  # With unquote fragments, we can pass any valid atom to def and dynamically define a function with that name. We’ll use unquote fragments heavily throughout the rest of this chapter.
end
