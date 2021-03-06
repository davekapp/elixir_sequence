defmodule Sequence do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    IO.puts "Sequence.Application start"
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      worker(Sequence.Supervisor, [123])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    # opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    opts = [strategy: :one_for_one, debug: [:trace]]
    {:ok, _pid} = Supervisor.start_link(children, opts)

    #{:ok, _pid} = Sequence.Supervisor.start_link(123)
  end
end
