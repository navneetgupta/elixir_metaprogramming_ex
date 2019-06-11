defmodule General.TraceableDefault do
  import General.TracerWithDefault

  # deftrace my_func(a \\ 1, b \\ 2)
  deftrace my_func(_a, 0), do: :error
  deftrace my_func(a \\ 1, b \\ 2), do: a / b

end
