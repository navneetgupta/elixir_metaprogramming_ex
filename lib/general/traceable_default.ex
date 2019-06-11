defmodule General.TraceableDefault do
  import General.TracerWithDefault
  #
  # deftraceable my_func(_a, 0) do
  #   :error
  #  end
  #
  # deftraceable my_func(a , b \\ 2) do
  #   a / b
  # end
  #
  deftraceable my_func(a, b) do
    a / b
  end

  deftrace div(a \\ 2, b \\ 1) do
    a / b
  end
  #
  # def my_func2(a \\ 1, b \\ 1) do
  #   a / b
  # end
end
