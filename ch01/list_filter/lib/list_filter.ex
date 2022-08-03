defmodule ListFilter do
  require Integer

  def call(list) do
    list
    |> Enum.reject(&(!Regex.match?(~r/^\d+$/, &1)))
    |> Enum.map(&String.to_integer/1)
    |> Enum.count(&Integer.is_odd/1)
  end
end
