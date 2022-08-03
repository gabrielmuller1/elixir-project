defmodule Exlivery.Factory do
  use ExMachina
  alias Exlivery.Users.User
  alias Exlivery.Orders.{Order, Item}

  def user_factory() do
    %User{
      name: "Joe",
      email: "joe@email.com",
      tax_id: "1234",
      age: 25,
      address: "Las Vegas"
    }
  end

  def item_factory() do
    %Item{
      description: "Pizza",
      category: :pizza,
      unity_price: Decimal.new("29.99"),
      quantity: 2
    }
  end

  def order_factory do
    %Order{
      amount: Decimal.new("149.95"),
      delivery_address: "Las Vegas",
      items: [
        build(:item, quantity: 2),
        build(:item, quantity: 3)
      ],
      user_tax_id: "1234"
    }
  end
end
