defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgent

  def create(filename \\ "report.csv") do
    orders = build_orders()

    File.write(filename, orders)
  end

  defp build_orders() do
    OrderAgent.list_all()
    |> Map.values()
    |> Enum.map(&order_string/1)
  end

  defp order_string(%{
         user_tax_id: user_tax_id,
         delivery_address: _delivery_address,
         items: items,
         amount: amount
       }) do
    items_string = Enum.map(items, &item_string/1) |> Enum.join(",")
    "#{user_tax_id},#{items_string},#{amount}\n"
  end

  defp item_string(%{
         description: _description,
         category: category,
         unity_price: unity_price,
         quantity: quantity
       }) do
    "#{category},#{quantity},#{unity_price}"
  end
end
