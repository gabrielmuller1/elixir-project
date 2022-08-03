defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Item

  describe "build/4" do
    test "should return an item when passes valid params" do
      response = Item.build("Pizza", :pizza, 29.99, 2)

      expected = {:ok, build(:item)}

      assert response == expected
    end

    test "should return an error when passes an invalid category" do
      response = Item.build("Pizza", :pizz, 0, 0)

      expected = {:error, :invalid_parameters}
      assert response == expected
    end

    test "should return an error when passes an invalid unity_price" do
      response = Item.build("Pizza", :pizza, "45.A", 1)

      expected = {:error, :invalid_price}
      assert response == expected
    end

    test "should return an error when passes an invalid quantity" do
      response = Item.build("Pizza", :pizza, 45, -1)

      expected = {:error, :invalid_parameters}
      assert response == expected
    end
  end
end
