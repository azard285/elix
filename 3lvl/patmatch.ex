defmodule Patter do
  def matching({:error, reason}), do: IO.inspect("Ошибка, по причине: #{reason}")
  def matching({:ok, value}) do
    IO.inspect("Получил значение #{value}")
  end
end

Patter.matching({:ok, 12})
Patter.matching({:error, "potomuchto"})
