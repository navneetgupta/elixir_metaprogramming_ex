defmodule CodeGen.FSM do
  fsm = [
    running: {:pause, :paused},
    running: {:stop, :stopped},
    paused: {:resume, :running}
  ]

  for {state, {action, next_state}} <- fsm do
    def unquote(action)(unquote(state)), do: unquote(next_state)
  end

  def initial, do: :running
end
