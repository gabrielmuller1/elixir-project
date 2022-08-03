defmodule ListFilterTest do
  use ExUnit.Case

  describe "call/1" do
    test "count the number of odd number for a given list" do
      list1 = ["1", "3", "6", "43", "banana", "6", "abc"]
      list2 = ["1", "6", "43"]
      list3 = ["1"]

      assert ListFilter.call(list1) == 3
      assert ListFilter.call(list2) == 2
      assert ListFilter.call(list3) == 1
    end

    test "passing an empty list" do
      list = []

      assert ListFilter.call(list) == 0
    end
  end
end
