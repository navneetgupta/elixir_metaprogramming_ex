defmodule General.Traceable do
  import General.Tracer

  deftraceable my_fun(a, b) do
    # a / b
  end
end
