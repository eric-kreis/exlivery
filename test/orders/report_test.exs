defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "creates the report file" do
      filename = "report_test.csv"

      OrderAgent.start_link()

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      Report.create(filename)

      response = File.read!(filename)

      expected_response =
        "12345678900,pizza,2,35.5japanese,2,22.72,116.44\n12345678900,pizza,2,35.5japanese,2,22.72,116.44\n"

      assert response == expected_response
    end
  end
end
