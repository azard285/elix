defmodule Max do
  def list(list) do
    listt(list, -32767)
  end

  def listt([], max), do: max
  def listt([h|t], max) do
    if h > max do
      max = h
      listt(t, max)
    else
      listt(t, max)
    end
  end
end

IO.inspect(Max.list([1,2,3,2,4,2,2]))
