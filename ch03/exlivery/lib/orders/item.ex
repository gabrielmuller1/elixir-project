defmodule Exlivery.Orders.Item do
  @cateories [:pizza, :hamburguer, :japanese_food]

  @keys [:description, :category, :unity_price, :quantity]
  @enforce_keys @keys

  defstruct @keys

  def build(description, category, unity_price, quantity)
      when category in @cateories and quantity > 0 do
    unity_price
    |> Decimal.cast()
    |> build_item(description, category, quantity)
  end

  def build(_description, _category, _unity_price, _quantity), do: {:error, :invalid_parameters}

  defp build_item({:ok, unity_price}, description, category, quantity) do
    {:ok,
     %__MODULE__{
       description: description,
       category: category,
       unity_price: unity_price,
       quantity: quantity
     }}
  end

  defp build_item(_error, _description, _category, _quantity), do: {:error, :invalid_price}
end
