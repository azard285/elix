defmodule Timer do
  use GenServer

  def start() do
    GenServer.start_link(__MODULE__, nil, name: MAN)
  end

  def cancel() do
    GenServer.cast(MAN, :cancel)
  end

  @impl true
  def init(_) do
      ref = Process.send_after(self(), :timer_done, 3_000)
      {:ok, ref}
  end

  @impl true
  def handle_info(:timer_done, state) do
    IO.puts("Timer done!")
    {:noreply, state}
  end

  @impl true
  def handle_call(_key, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast(:cancel, state) do
    Process.cancel_timer(state)
    IO.puts("Timer canceled!")
    {:noreply, state}
  end
end


Timer.start()
