defmodule GenReport.Parser do
  def parse_file(filename) do
    "reports/#{filename}"
    |> File.stream!()
    |> Stream.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> update_list_index(0, &String.downcase/1)
    |> update_list_index(3, &get_month/1)
    |> update_list_index(1, &String.to_integer/1)
    |> update_list_index(2, &String.to_integer/1)
    |> update_list_index(4, &String.to_integer/1)
  end

  defp update_list_index(list, index, fun),
    do: List.update_at(list, index, fun)

  defp get_month(month) do
    month_index = String.to_integer(month) - 1

    [
      "janeiro",
      "fevereiro",
      "março",
      "abril",
      "maio",
      "junho",
      "julho",
      "agosto",
      "setembro",
      "outubro",
      "novembro",
      "dezembro"
    ]
    |> Enum.at(month_index, "")
  end
end
