defmodule Sequence.StackServer do
  use GenServer

  def handle_call(:pop, _from, _stack = [h | t]) do
    {:reply, h, t}
  end

  def handle_cast({:push, item}, stack), do: {:noreply, [item | stack]}
end
