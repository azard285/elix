defmodule Fac do
  def factoriall(0, acc), do: acc
  def factoriall(n, acc) do
    factoriall(n-1, acc*n)
  end

  def factorial(n) do
    factoriall(n, 1)
  end
end

IO.inspect(Fac.factorial(4))
