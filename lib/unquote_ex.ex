# unquote is used when need to inject values from an outside context (where value was defined).
#
# iex
# iex(1)> name = "Navneet Gupta"
# iex(2)> quote do: "My name is " <> name
# {:<>, [context: Elixir, import: Kernel], ["My name is ", {:name, [], Elixir}]}
# iex(3)> quote do: "My name is " <> unquote(name)
# {:<>, [context: Elixir, import: Kernel], ["My name is ", "Navneet Gupta"]}
