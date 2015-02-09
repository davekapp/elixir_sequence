defmodule Sequence.Supervisor do
  use Supervisor

  def start_link(start_num) do
    IO.puts "Sequence.Supervisor start_link"
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [start_num])
    start_workers(sup, start_num)
    result
  end

  def start_workers(sup, start_num) do
    # start the stash worker first
    {:ok, stash} = Supervisor.start_child(sup, worker(Sequence.Stash, [start_num]))

    # now start the subsupervisor for the sequence server
    Supervisor.start_child(sup, supervisor(Sequence.SubSupervisor, [stash]))
  end

  def init(_) do
    IO.puts "Sequence.Supervisor init"
    supervise [], strategy: :one_for_one
  end

end
