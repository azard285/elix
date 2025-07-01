defmodule Sum do
  def list([]), do: 0
  def list([h|t]) do
    h + list(t)
  end
end

IO.puts(Sum.list([1,2,3]))
