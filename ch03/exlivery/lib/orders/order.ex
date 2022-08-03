defmodule Exlivery.Orders.Order do
  @keys [:user_tax_id, :delivery_address, :items, :amount]
  @enforce_keys @keys

  defstruct @keys

  alias Exlivery.Users.User
  alias Exlivery.Orders.Item

  def build(%User{tax_id: user_tax_id, address: address}, [%Item{} | _items] = items) do
    {:ok,
     %__MODULE__{
       user_tax_id: user_tax_id,
       delivery_address: address,
       items: items,
       amount: calculate_amount(items)
     }}
  end

  def build(_, _), do: {:error, :invalid_parameters}

  defp calculate_amount(items) do
    Enum.reduce(items, Decimal.new("0.00"), fn %{unity_price: unity_price, quantity: quantity},
                                               acc ->
      unity_price
      |> Decimal.mult(quantity)
      |> Decimal.add(acc)
    end)
  end
end
