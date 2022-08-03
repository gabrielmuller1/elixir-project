defmodule SumListTest do
  use ExUnit.Case

  describe "call/1" do
    test "returns the list sum" do
      list = [1, 2, 3]
      expected = 6

      assert SumList.call(list) == expected
    end
  end
end
