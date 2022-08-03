defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.CreateOrUpdate

  setup %{} do
    Exlivery.start_agents()

    {:ok,
     user: %{
       name: "Joe",
       email: "joe@email.com",
       tax_id: "123456",
       age: 25,
       address: "New York"
     }}
  end

  describe "call/1" do
    test "should save a valid user", %{user: user} do
      assert CreateOrUpdate.call(user) == :ok
    end

    test "should not save an invalid valid user", %{user: user} do
      assert CreateOrUpdate.call(%{user | age: 15}) == {:error, :invalid_parameters}
    end
  end
end
