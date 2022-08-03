defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(%{users: %{}, products: %{}}, fn [id, product_name, price],
                                                    %{users: users, products: products} = acc ->
      %{
        acc
        | users: update_map_value(users, id, price, price),
          products: update_map_value(products, product_name, 1, 1)
      }
    end)
  end

  def build_from_many(filenames) when not is_list(filenames), do: {:error, :invalid_arg}

  def build_from_many(filenames) do
    result =
      filenames
      |> Task.async_stream(&build/1)
      |> Enum.reduce(%{users: %{}, products: %{}}, fn {:ok, report},
                                                      %{users: users, products: products} = acc ->
        %{
          acc
          | users: merge_maps(users, report.users),
            products: merge_maps(products, report.products)
        }
      end)

    {:ok, result}
  end

  def fetch_higher_cost(report, option) when option in [:users, :products] do
    {:ok, Enum.max_by(report[option], fn {_id, value} -> value end)}
  end

  def fetch_higher_cost(_, _), do: {:error, :invalid_option}

  defp merge_maps(first_map, second_map),
    do:
      Map.merge(first_map, second_map, fn _key, first_value, second_value ->
        first_value + second_value
      end)

  defp update_map_value(map, key, default, value),
    do: Map.update(map, key, default, fn existing_value -> existing_value + value end)
end
