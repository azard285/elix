defmodule Fact do
  def factorial(0), do: 1
  def factorial(n) do
     n * factorial(n-1)
  end
end


IO.puts(Fact.factorial(5))
