defmodule General.Hygiene do
  @moduledoc """
    iex -S mix

    iex(1)> ast = quote do
      if meaning_to_life == 42 do
        IO.puts "It's Correct Bro!!"
      else
        IO.puts "You need to workon!!"
      end
    end
    iex(2)> Code.eval_quoted(ast, meaning_to_life: 42)
    ** (CompileError) nofile:1: undefined function meaning_to_life/0
    (stdlib) lists.erl:1354: :lists.mapfoldl/3
    (elixir) expanding macro: Kernel.if/2
    nofile:1: (file)

    iex(3)> ast = quote do
      if var!(meaning_to_life) == 42 do
        IO.puts "It's Correct Bro!!"
      else
        IO.puts "You need to workon!!"
      end
    end

    iex(4)> Code.eval_quoted(ast, meaning_to_life: 42)
    It's Correct Bro!!
    {:ok, [meaning_to_life: 42]}
  """

  defmacro hygiene do
    quote do: meaning_to_life = 1
  end
end

defmodule General.Hygiene.Test do
  def test_hygiene do
    require General.Hygiene
    # Defined variable in Module_context
    meaning_to_life = 21
    # redefine variable in macro context to 1
    General.Hygiene.hygiene()
    # still pointing to old value i.e. 21
    meaning_to_life
  end
end

# iex -S mix
# iex(1)> General.Hygiene.Test.test_hygiene()
# 21

# To Override
#
defmodule General.HygieneOverload do
  defmacro test_hygiene do
    quote do: var!(meaning_to_life) = 1
  end
end

defmodule General.HygieneOverload.Test do
  def test_hygiene do
    require General.HygieneOverload
    meaning_to_life = 21
    General.HygieneOverload.test_hygiene()
    # will have overloaded value from macro context variable to 1
    meaning_to_life
  end
end

# iex -S mix
# iex(1)> General.HygieneOverload.Test.test_hygiene
# 1

# Variable hygiene only works because Elixir annotates variables with their context. For example, a variable x defined on line 3 of a module would be represented as:
#
# {:x, [line: 3], nil}
# However, a quoted variable is represented as:
#
# defmodule Sample do
#   def quoted do
#     quote do: x
#   end
# end
#
# Sample.quoted #=> {:x, [line: 3], Sample}
#
# Notice that the third element in the quoted variable is the atom Sample, instead of nil, which marks the variable as coming from the Sample module. Therefore, Elixir considers these two variables as coming from different contexts and handles them accordingly.

# Elixir provides similar mechanisms for imports and aliases too. This guarantees that a macro will behave as specified by its source module rather than conflicting with the target module where the macro is expanded. Hygiene can be bypassed under specific situations by using macros like var!/2 and alias!/1,
