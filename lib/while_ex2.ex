defmodule WhileEx2 do
  defmacro while(expr, do: l_block) do
    quote do
      try do
        for _ <- Stream.cycle([:ok]) do
          if unquote(expr) do
            unquote(l_block)
          else
            WhileEx2.break()
          end
        end
      catch
        :break -> :ok
      end
    end
  end

  def break, do: throw(:break)
end

# iex -S mix
# import WhileEx2
# pid = spawn fn ->
#   while true do
#     receive do
#       :stop ->
#         IO.puts("Stopping now !!")
#         break
#       msg ->
#         IO.puts("Received Msg: #{inspect msg}")
#       end
#     end
# end
#
# send pid, :hello
# send pid, :Hi_there
# send pid, :stop
#
# Process.alive?(pid)
