defmodule Logger3 do
  defmacro log(msg) do
    if Application.get_env(:logger, :enabled) do
      quote do
        IO.puts("Logged message: #{unquote(msg)}")
      end
    end
  end
end

defmodule Example do
  require Logger3

  def test do
    Logger3.log("This is a log message")
  end
end

# With logging enabled our test function would result in code looking something like this:
#
# def test do
#   IO.puts("Logged message: #{"This is a log message"}")
# end
# If we disable logging the resulting code would be:
#
# def test do
# end
