defmodule Sequence.Server do
  use GenServer

  ##############
  # External API
  ##############

  def start_link(start_num) do
    GenServer.start_link(__MODULE__, start_num, name: __MODULE__)
  end

  def next_num do
    GenServer.call __MODULE__, :next_num
  end

  def increment_num(delta) do
    GenServer.cast __MODULE__, {:increment_num, delta}
  end

  def mod_name do
    __MODULE__
  end

  #########################
  # Internal implementation
  #########################

  def handle_call(:next_num, _from, current_num) do
    {:reply, current_num, current_num + 1}
  end

  def handle_cast({:increment_num, delta}, current_num) do
    {:noreply, current_num + delta}
  end

end
