import Tokens.Cache

defmodule Tokens.Generator.Supervisor do
  use Supervisor


  ## Client API

  def start_link(json_file \\ [], generators \\ 1) do
    Supervisor.start_link(__MODULE__, [json_file, generators])
  end

  def start_generatoes(sup, json_file \\ []) do
    {:ok, pid} = Supervisor.start_child(sup, json_file)
    pid
  end

  ## Server Callbacks
  def init([json_file, generators]) do
    {:ok, cache} = Tokens.Generator.start_link

    #Use the cache to put the json file
    GenServer.cast(cache, {:create_table, :general})
    GenServer.call(cache, {:put, :general, :json, json_file})

    children = []

    Enum.each 1..generators, fn x ->
      name_worker_str = "Tokens.Generator.#{x}"
      children = [worker(Tokens.Generator, [name_worker_str, json_state, cache], [restart: :transient, name:]) | children]
    end

    supervise(children, strategy: :simple_one_for_one, max_restarts: 3, max_seconds: 5)
  end

end
