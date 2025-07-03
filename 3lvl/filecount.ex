defmodule Count do
  def linec(file) do
    case File.read(file) do
      {:ok, content} ->
        len = content |> String.split("\n") |> length()
        IO.inspect(len)
      {:error, reason} ->
        IO.inspect("Error: ", reason)
    end
  end
end

Count.linec("text.txt")
