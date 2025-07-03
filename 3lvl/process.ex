defmodule Processes do
  def run() do
    spawn(fn -> loop() end)
  end

  def loop() do
    receive do
      {:ping, from} ->
        IO.inspect("ping from: #{inspect(from)} \npong from: #{inspect(self())}")
        send(from, {:ping, self()})
        loop()
      after
        10_000 -> IO.puts("Process #{inspect(self())} timed out")
    end
  end
end


pid1 = Processes.run()
pid2 = Processes.run()

IO.inspect([self(), pid1, pid2])

send(pid1, {:ping, pid2})
