defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Order

  describe "build/4" do
    test "should return an order when passes valid params" do
      user = build(:user)

      items = [
        build(:item, quantity: 2),
        build(:item, quantity: 3)
      ]

      response = Order.build(user, items)
      expected = {:ok, build(:order)}

      assert response == expected
    end

    test "should return an error when a valid user is not provided" do
      items = [
        build(:item, quantity: 2)
      ]

      response = Order.build(%{}, items)

      assert response == {:error, :invalid_parameters}
    end

    test "should return an error when order items is not provided" do
      user = build(:user)

      response = Order.build(user, [])

      assert response == {:error, :invalid_parameters}
    end
  end
end
