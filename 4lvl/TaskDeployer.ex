defmodule Deploy do
  use GenServer

  def start() do
    GenServer.start_link(__MODULE__, [], name: MAIN)
  end

  def tasks(file) do
    GenServer.call(MAIN, {:tasks, file})
  end
#--------------------------------------------------- not use funct
  def loop(file) do
    case File.read(file) do
      {:ok, content} ->
        split = content |> String.split("\n")
        print(split)
      {:error, reason} ->
        IO.inspect("Error: #{reason}")
    end
  end

  def pr(h) do
    IO.inspect("Процесс #{inspect(self())}, выводит: #{h}")
  end

  def print([]), do: []
  def print([h|t]) do
    spawn(fn -> pr(h) end)
    print(t)
  end

  @impl true
  def init(initial_state) do
    {:ok, initial_state}
  end

  @impl true
  def handle_call({:tasks, file}, _from, state) do
    loop(file)
    {:reply, :ok, state}
  end

  @impl true
  def handle_cast(_key, state) do
    {:noreply, state}
  end
end


Deploy.start()
Deploy.tasks("text.txt")
