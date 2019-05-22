defmodule AnotherIf do
  defmacro my_if(expr, do: if_block), do: if(expr, do: if_block, else: nil)

  defmacro my_if(expr, do: if_block, else: else_block) do
    quote do
      case unquote(expr) do
        result when result in [false, nil] -> unquote(else_block)
        _ -> unquote(if_block)
      end
    end
  end
end

# iex -S mix
# iex(1)> require AnotherIf
# AnotherIf
# iex(2)> AnotherIf.my_if 4 == 5 do
# ...(2)> IO.puts(" Evaluated True")
# ...(2)> else
# ...(2)> IO.puts(" Evaluated False")
# ...(2)> end
#  Evaluated False
# :ok
# iex(3)> AnotherIf.my_if 4 == 4 do
# ...(3)> IO.puts(" Evaluated True")
# ...(3)> else
# ...(3)> IO.puts(" Evaluated False")
# ...(3)> end
#  Evaluated True
# :ok
