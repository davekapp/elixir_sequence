defmodule Sequence.Server do
  use GenServer

  ##############
  # External API
  ##############

  def start_link(stash_pid) do
    IO.puts "Sequence.Server start_link"
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
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

  def init(stash_pid) do
    IO.puts "Sequence.Server init"
    #current_num = Sequence.stash.get_value stash_pid
    current_num = Sequence.Stash.get_value stash_pid
    IO.puts "current_num: #{current_num}"
    {:ok, {current_num, stash_pid}}
  end

  def handle_call(:next_num, _from, {current_num, stash_pid}) do
    {:reply, current_num, {current_num + 1, stash_pid}}
  end

  def handle_cast({:increment_num, delta}, {current_num, stash_pid}) do
    {:noreply, {current_num + delta, stash_pid}}
  end

  def terminate(_reason, {current_num, stash_pid}) do
    Sequence.Stash.save_value stash_pid, current_num
  end

end
