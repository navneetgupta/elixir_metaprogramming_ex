defmodule General.TraceableDefault do
  import General.TracerWithDefault

  deftraceable my_func(_a, 0) do
    :error
   end

  deftraceable my_func(a \\ 1, b \\ 2) when a > b do
    a / b
  end

  deftraceable my_func(a, b) do
    b / a
  end
end
