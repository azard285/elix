defmodule Keystore do
  use GenServer

  def start_link(args) do
     GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def start() do
    {:ok, pid} = start_link(%{})
    IO.inspect("KeyStore: #{inspect(pid)}")
  end

  def put(key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def del(key) do
    GenServer.cast(__MODULE__, {:del, key})
  end

  def stop() do
    GenServer.call(__MODULE__, :stop)
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
  def handle_call(:stop, _from, state) do
    exit(:normal)
    {:reply, :ok, state}
  end

  @impl true
  def handle_cast({:put, key, value}, state), do: {:noreply, Map.put(state, key, value)}
  @impl true
  def handle_cast({:del, key}, state), do: {:noreply, Map.delete(state, key)}
end


defmodule Supervisorr do
  use Supervisor

  def start() do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      {Keystore, %{}}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end


# Supervisorr.start()

# Keystore.stop()
# Process.whereis()
