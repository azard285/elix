defmodule Keystore do
  use GenServer

  def start() do
    GenServer.start_link(__MODULE__, %{}, name: MAIN)
  end

  def put(key, value) do
    GenServer.cast(MAIN, {:put, key, value})
  end

  def get(key) do
    GenServer.call(MAIN, {:get, key})
  end

  def del(key) do
    GenServer.cast(MAIN, {:del, key})
  end

  @impl true
  def init(init_arg) do
      {:ok, init_arg}
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  @impl true
  def handle_cast({:put, key, value}, state), do: {:noreply, Map.put(state, key, value)}
  @impl true
  def handle_cast({:del, key}, state), do: {:noreply, Map.delete(state, key)}
end

Keystore.start()

Keystore.put("age", 12)
Keystore.put(15, 150)
Keystore.put("ge", 13)

IO.inspect(Keystore.get("age"))
IO.inspect(Keystore.get("ge"))

IO.inspect(Keystore.get(15))
Keystore.del(15)
IO.inspect(Keystore.get(15))
