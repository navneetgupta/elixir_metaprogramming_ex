defmodule General.BeforeCompile do
  # @before_compile unquote(__MODULE__)

  # @before_compile attribute accepts a module argument where a __before_compile__/1 macro must be defined.

  # This attribute helps to notify compiler that before finishing compilation one more step is required. __before_compile__\1 macro should be defined.
  #

  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
      Module.register_attribute(__MODULE__, :tests, accumulate: true)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def run do
        IO.puts("Running the tests (#{inspect(@tests)})")
      end
    end
  end
end

defmodule General.BeforeCompile.Test do
  use General.BeforeCompile

  @tests "asas"
  @tests "sdsdsd"
end
