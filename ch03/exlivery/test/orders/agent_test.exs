defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory
  alias Exlivery.Orders.Agent, as: OrderAgent

  setup %{} do
    Exlivery.start_agents()
    :ok
  end

  describe "save/1" do
    test "should save a valid order" do
      order = build(:order)

      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    test "should return an order for a valid id" do
      order = build(:order)

      {:ok, order_id} = OrderAgent.save(order)

      assert OrderAgent.get(order_id) == {:ok, order}
    end

    test "should not return an order when is given an invalid id" do
      assert OrderAgent.get("SOMETHING") == {:error, :not_found}
    end
  end
end
