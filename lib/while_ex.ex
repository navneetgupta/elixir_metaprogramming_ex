defmodule WhileEx do
  defmacro while(expr, do: l_block) do
    quote do
      try do
        for _ <- Stream.cycle([:ok]) do
          if unquote(expr) do
            unquote(l_block)
          else
            throw(:break)
          end
        end
      catch
        :break -> :ok
      end
    end
  end
end
