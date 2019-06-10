defmodule General.TraceableGuard do
  import General.TracerWithGuard

  deftraceable my_func(_a, 0) do
    :error
   end

  deftraceable my_func(a, b) when a > b do
    a / b
  end

  deftraceable my_func(a, b) do
    b / a
  end

  def my_func2(a \\ 1, b \\ 1) do
    a / b
  end
end
