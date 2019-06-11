defmodule CodeGen.TraceableFSM do
  import CodeGen.FSMTracer

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
