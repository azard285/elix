defmodule Fib do
  def fibonachi(1), do: 1
  def fibonachi(2), do: 1
  def fibonachi(n) do
    fibonachi(n-1) + fibonachi(n-2)
  end
end


IO.puts(Fib.fibonachi(3))
