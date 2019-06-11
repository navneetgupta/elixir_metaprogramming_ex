defmodule CodeGen.TraceableFSM do
  use CodeGen.FSMTracer

  fsm = [
    running: {:pause, :paused},
    running: {:stop, :stopped},
    paused: {:resume, :running}
  ]

  for {state, {action, next_state}} <- fsm do
    deftrace(unquote(action)(unquote(state)), do: unquote(next_state))
  end

  deftrace(initial(), do: :running)
end

# iex -S mix
# iex(1)> CodeGen.TraceableFSM.initial
# iex(2)> CodeGen.TraceableFSM.initial |> CodeGen.TraceableFSM.pause
# iex(3)> CodeGen.TraceableFSM.initial |> CodeGen.TraceableFSM.pause |> CodeGen.TraceableFSM.resume
# iex(4)> CodeGen.TraceableFSM.initial |> CodeGen.TraceableFSM.pause |> CodeGen.TraceableFSM.resume |> CodeGen.TraceableFSM.stop
