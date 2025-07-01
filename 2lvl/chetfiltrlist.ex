defmodule Filtr do
  def list(list) do
    for x <- list, rem(x, 2) == 0, do: x
  end
end

IO.inspect(Filtr.list([1,2,3,4,5,6,7]))
