defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.User

  describe "build/5" do
    test "should return an user when passes valid params" do
      response = User.build("Joe", "joe@email.com", "1234", 25, "Las Vegas")

      expected = {:ok, build(:user)}

      assert response == expected
    end

    test "should return an error when passes invalid params" do
      response = User.build("Joe", "joe@email.com", "1234", 17, "Las Vegas")

      expected = {:error, :invalid_parameters}
      assert response == expected
    end
  end
end
