defmodule Tokens.Generator do
  use GenServer

  def start_link(name_worker_str, json_state, cache) do
    GenServer.start_link(__MODULE__, [name_worker_str, json_state, cache], [{:name, name_worker_str}])
  end

  @doc "stopping the cache server"
  def stop() do
    GenServer.cast(:NAME, :stop)
  end

  def init(name_worker_str, json_state, cache) do
    {:ok, %State{name: name_worker_str, json: port, cache: cache}, 0 }
  end

  def handle_cast({:generate_async!}, state) do
    
  end

  def handle_call({:generate!}, _from, state) do

  end

  def handle_call({:generate_encrypted!}, _from, state) do

  end



end
