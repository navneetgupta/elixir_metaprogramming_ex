defmodule UnderstandingMacro1 do
end

#  In Elixir the abstract syntax tree (AST), the internal representation of our code, is composed of tuples. These tuples contain three parts: function name, metadata, and function arguments.

# Using quote/2 we can convert Elixir code into its underlying representation:

# to See internal representation of a expression, Use:
#  iex> quote do: 42
#  iex> quote do: 1 + 2
#  iex> quote do: if value, do: "True", else: "False"

# UnQuote
# To inject new code or values we use unquote/1. When we unquote an expression it will be evaluated and injected into the AST. To demonstrate unquote/1 let’s look at some examples:
#
# iex> denominator = 2
# 2
# iex> quote do: divide(42, denominator)
# {:divide, [], [42, {:denominator, [], Elixir}]}
# iex> quote do: divide(42, unquote(denominator))
# {:divide, [], [42, 2]}

# In the first example our variable denominator is quoted so the resulting AST includes a tuple for accessing the variable. In the unquote/1 example the resulting code includes the value of denominator instead.

# Because macros replace code in our application, we can control when and what is compiled.

# An example of this can be found in the Logger module. When logging is disabled no code is injected and the resulting application contains no references or function calls to logging. This is different from other languages where there is still the overhead of a function call even when the implementation is NOP.
