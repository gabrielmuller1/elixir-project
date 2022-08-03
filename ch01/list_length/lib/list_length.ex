defmodule ListLength do
  def call([]), do: 0

  def call([_head | _tail] = list), do: list_length(list, 0)

  defp list_length([], acc), do: acc

  defp list_length([_head | tail], acc), do: list_length(tail, acc + 1)
end
