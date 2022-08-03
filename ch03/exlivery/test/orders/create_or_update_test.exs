defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  setup %{} do
    Exlivery.start_agents()
    %{tax_id: user_tax_id} = user = build(:user)
    UserAgent.save(user)

    {:ok, user_tax_id: user_tax_id, items: build_list(2, :item)}
  end

  describe "call/1" do
    test "should save an order when all params are valid", %{
      user_tax_id: user_tax_id,
      items: items
    } do
      response = CreateOrUpdate.call(%{user_tax_id: user_tax_id, items: items})

      assert {:ok, _uuid} = response
    end

    test "should not save an order when user tax id is is invalid", %{items: items} do
      response = CreateOrUpdate.call(%{user_tax_id: "12365974854", items: items})

      assert response == {:error, :not_found}
    end

    test "should not save an order when at least one item is invalid", %{
      user_tax_id: user_tax_id,
      items: [first_item | _]
    } do
      response = CreateOrUpdate.call(%{user_tax_id: user_tax_id, items: [first_item, %{}]})

      assert response == {:error, :invalid_items}
    end

    test "should not save an order when not provide order items", %{user_tax_id: user_tax_id} do
      response = CreateOrUpdate.call(%{user_tax_id: user_tax_id, items: []})

      assert response == {:error, :invalid_parameters}
    end
  end
end
