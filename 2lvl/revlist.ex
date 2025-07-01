defmodule Revers do
  def list([]), do: []
  def list([h|t]), do: list(t) ++ [h]
end

IO.inspect(Revers.list([1,2,3]))
