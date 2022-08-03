defmodule Exlivery.Orders.CreateOrUpdate do
  alias Exlivery.Orders.{Order, Item}
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Orders.Agent, as: OrderAgent

  def call(%{user_tax_id: user_tax_id, items: items}) do
    with {:ok, user} <- UserAgent.get(user_tax_id),
         {:ok, order_items} <- build_items(items),
         {:ok, order} <- Order.build(user, order_items) do
      OrderAgent.save(order)
    else
      reply -> reply
    end
  end

  defp build_items(items) do
    items
    |> Enum.map(&build_item/1)
    |> handle_build()
  end

  defp build_item(item) do
    with %{
           description: description,
           category: category,
           unity_price: unity_price,
           quantity: quantity
         } <- item,
         {:ok, item} <- Item.build(description, category, unity_price, quantity) do
      item
    else
      {:error, _reason} = error ->
        error

      _ ->
        {:error, :invalid_item}
    end
  end

  defp handle_build(items) do
    if Enum.all?(items, &is_struct/1) do
      {:ok, items}
    else
      {:error, :invalid_items}
    end
  end
end
