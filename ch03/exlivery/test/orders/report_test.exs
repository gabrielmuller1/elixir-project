defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Report
  alias Exlivery.Orders.Agent, as: OrderAgent

  setup %{} do
    Exlivery.start_agents()
    :ok
  end

  describe "create/1" do
    test "should create the report file" do
      build_list(3, :order)
      |> Enum.each(&OrderAgent.save/1)

      filename = "report_test.csv"

      assert Report.create(filename) == :ok

      response = File.read!(filename)

      assert response ==
               "1234,pizza,2,29.99,pizza,3,29.99,149.95\n" <>
                 "1234,pizza,2,29.99,pizza,3,29.99,149.95\n" <>
                 "1234,pizza,2,29.99,pizza,3,29.99,149.95\n"
    end
  end
end
