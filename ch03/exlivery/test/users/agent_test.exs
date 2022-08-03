defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent

  setup %{} do
    Exlivery.start_agents()
    :ok
  end

  describe "save/1" do
    test "should save a valid user" do
      user = build(:user)

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    test "should return an user for a valid tax_id" do
      %{tax_id: tax_id} = user = build(:user)
      UserAgent.save(user)

      assert UserAgent.get(tax_id) == {:ok, user}
    end

    test "should not return an user when is given an invalid tax_id" do
      assert UserAgent.get("SOMETHING") == {:error, :not_found}
    end
  end
end
