defmodule Chet do
  def proverka(n) do
    if rem(n, 2) != 0 do
      IO.puts("nechet")
    else
      IO.puts("chet")
    end
  end
end


Chet.proverka(2)
Chet.proverka(3)
