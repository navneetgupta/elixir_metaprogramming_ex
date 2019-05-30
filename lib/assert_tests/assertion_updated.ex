defmodule AssertTests.AssertionUpdated do
  defmacro assert({operation, _, [lhs, rhs]}) do
    quote bind_quoted: [operation: operation, lhs: lhs, rhs: rhs] do
      AssertTests.AssertionUpdated.Test.assert(operation, lhs, rhs)
    end
  end

  defmacro __using__(_options) do
    quote do
      # unquote(__MODULE__) => inject current value of module i.e. AssertTests.AssertionUpdated
      # __MODULE__ => where macro is getting used
      import unquote(__MODULE__)

      # IO.puts("unquote(__MODULE__): #{inspect(unquote(__MODULE__))}")
      # IO.puts("__MODULE__: #{inspect(__MODULE__)}")
      Module.register_attribute(__MODULE__, :tests, accumulate: true)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      # Define a run method in the __MODULE__ which when invoked will call AssertTests.AssertionUpdated.Test.run(@tests, __MODULE__)
      # defmodule AssertTests.MathTest1 do
      #   ...
      #   def run, do:  AssertTests.AssertionUpdated.Test.run(@tests, AssertTests.MathTest1)
      # end
      def run, do: AssertTests.AssertionUpdated.Test.run(@tests, __MODULE__)
    end
  end

  defmacro test(description, do: test_block) do
    test_func = String.to_atom(description)

    quote do
      @tests {unquote(test_func), unquote(description)}
      # Define a description() method in the __MODULE__ which when invoked will call corresponding test do block
      # defmodule AssertTests.MathTest1 do
      #   ...
      #   def String.to_atom(integers can be added and subtracted)() do
      #     assert 1 + 1 == 2
      #     assert 2 + 3 == 5
      #     assert 5 - 5 == 10
      #   end
      # end
      def unquote(test_func)(), do: unquote(test_block)
    end
  end
end

defmodule AssertTests.AssertionUpdated.Test do
  def assert(:==, lhs, rhs) when lhs == rhs do
    :ok
  end

  def assert(:==, lhs, rhs) do
    {:fail,
     """
     Failure:
     Expected:       #{lhs}
     to be equal to: #{rhs}
     """}
  end

  def assert(:>, lhs, rhs) when lhs > rhs do
    :ok
  end

  def assert(:>, lhs, rhs) do
    {:fail,
     """
     Failure:
     Expected:           #{lhs}
     to be greater than: #{rhs}
     """}
  end

  def assert(:>=, lhs, rhs) when lhs >= rhs do
    :ok
  end

  def assert(:>=, lhs, rhs) do
    {:fail,
     """
     Failure:
     Expected:                     #{lhs}
     to be greater than/ equal to: #{rhs}
     """}
  end

  def assert(:<, lhs, rhs) when lhs < rhs do
    :ok
  end

  def assert(:<, lhs, rhs) do
    {:fail,
     """
     Failure:
     Expected:           #{lhs}
     to be lesser than:  #{rhs}
     """}
  end

  def assert(:<=, lhs, rhs) when lhs <= rhs do
    :ok
  end

  def assert(:<=, lhs, rhs) do
    {:fail,
     """
     Failure:
     Expected:                     #{lhs}
     to be lesser than / equal to: #{rhs}
     """}
  end

  def run(tests, module) do
    Enum.each(tests, fn {test_func, description} ->
      case apply(module, test_func, []) do
        :ok ->
          IO.write(".")

        {:fail, reason} ->
          IO.puts("""
          ===============================================
          FAILURE: #{description}
          ===============================================
          #{reason}
          """)
      end
    end)
  end
end
