defmodule GenReport do
  alias GenReport.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(
      %{"all_hours" => %{}, "hours_per_month" => %{}, "hours_per_year" => %{}},
      fn [name, qtd_hours, _day, month, year],
         %{
           "all_hours" => all_hours,
           "hours_per_month" => hours_per_month,
           "hours_per_year" => hours_per_year
         } = acc ->
        %{
          acc
          | "all_hours" => update_map_value(all_hours, name, qtd_hours, qtd_hours, &sum_values/2),
            "hours_per_month" =>
              update_nested_map_value(
                hours_per_month,
                name,
                month,
                qtd_hours,
                &sum_values/2
              ),
            "hours_per_year" =>
              update_nested_map_value(
                hours_per_year,
                name,
                year,
                qtd_hours,
                &sum_values/2
              )
        }
      end
    )
  end

  def build(), do: {:error, "Insira o nome de um arquivo"}

  def build_from_many(file_names) when is_list(file_names) do
    file_names
    |> Task.async_stream(&build/1)
    |> Enum.reduce(
      %{"all_hours" => %{}, "hours_per_month" => %{}, "hours_per_year" => %{}},
      fn {:ok, report},
         %{
           "all_hours" => all_hours,
           "hours_per_month" => hours_per_month,
           "hours_per_year" => hours_per_year
         } = acc ->
        %{
          acc
          | "all_hours" => merge(all_hours, report["all_hours"]),
            "hours_per_month" => deep_merge(hours_per_month, report["hours_per_month"]),
            "hours_per_year" => deep_merge(hours_per_year, report["hours_per_year"])
        }
      end
    )
  end

  def build_from_many([]), do: {:error, "Insira nomes arquivos válidos"}

  def build_from_many(), do: {:error, "Insira nomes arquivos válidos"}

  defp merge(left, right) do
    Map.merge(left, right, fn _key, left_value, right_value ->
      left_value + right_value
    end)
  end

  defp deep_merge(left, right) do
    Map.merge(left, right, fn _key, left_map, right_map ->
      merge(left_map, right_map)
    end)
  end

  defp update_nested_map_value(map, key, nested_key, default \\ 0, value, fun) do
    update_in(
      map,
      [Access.key(key, %{}), Access.key(nested_key, default)],
      &fun.(&1, value)
    )
  end

  def update_map_value(map, key, default, value, fun),
    do: Map.update(map, key, default, &fun.(&1, value))

  defp sum_values(first_value, second_value), do: first_value + second_value
end
