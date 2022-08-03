defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "builds the report" do
      file_name = "report_test.csv"

      response = ReportsGenerator.build(file_name)

      expected = %{
        products: %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pizza" => 2
        },
        users: %{
          "1" => 48,
          "10" => 36,
          "2" => 45,
          "3" => 31,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      assert response == expected
    end
  end

  describe "fetch_higher_cost/2" do
    test "when the option is ':users', should return the user who spent the most" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost(:users)

      expected = {:ok, {"5", 49}}

      assert response == expected
    end

    test "when the option is ':products', should return the most sold product" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost(:products)

      expected = {:ok, {"esfirra", 3}}

      assert response == expected
    end

    test "should return an error when is given an invalid option" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost(:sales)

      expected = {:error, :invalid_option}

      assert response == expected
    end
  end

  describe "build_from_many/1" do
    test "should builds the report when is given a valid arg" do
      filenames = ["report_1.csv", "report_2.csv", "report_3.csv"]

      {:ok, response} = ReportsGenerator.build_from_many(filenames)

      expected = %{
        products: %{
          "açaí" => 37742,
          "churrasco" => 37650,
          "esfirra" => 37462,
          "hambúrguer" => 37577,
          "pizza" => 37365,
          "pastel" => 37392,
          "prato_feito" => 37519,
          "sushi" => 37293
        },
        users: %{
          "1" => 278_849,
          "10" => 268_317,
          "2" => 271_031,
          "3" => 272_250,
          "4" => 277_054,
          "5" => 270_926,
          "6" => 272_053,
          "7" => 273_112,
          "8" => 275_161,
          "9" => 274_003,
          "11" => 268_877,
          "12" => 276_306,
          "13" => 282_953,
          "14" => 277_084,
          "15" => 280_105,
          "16" => 271_831,
          "17" => 272_883,
          "18" => 271_421,
          "19" => 277_720,
          "20" => 273_446,
          "21" => 275_026,
          "22" => 278_025,
          "23" => 276_523,
          "24" => 274_481,
          "25" => 274_512,
          "26" => 274_199,
          "27" => 278_001,
          "28" => 274_256,
          "29" => 273_030,
          "30" => 275_978
        }
      }

      assert response == expected
    end

    test "should return an error when is given an invalid arg" do
      filenames = "report_1.csv"

      reponse = ReportsGenerator.build_from_many(filenames)

      assert reponse == {:error, :invalid_arg}
    end
  end
end
