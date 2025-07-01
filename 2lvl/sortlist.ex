defmodule Sort do

  def past([], h), do: [h]
  def past([h|t], pasted) do
    if pasted > h do
      [h] ++ past(t, pasted)
    else
        [pasted] ++ [h] ++ t
    end
  end

  def list([], sort), do: sort
  def list([h|t], sort) do
    new = past(sort, h)
    list(t, new)
  end

  def sortlist(list) do
    list(list, [])
  end
end


IO.inspect(Sort.sortlist([1,5,2,4,3]))
