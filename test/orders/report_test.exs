defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "creates the report file" do
      filename = "report_test"

      OrderAgent.start_link()

      order1 = build(:order)
      {:ok, order1_uuid} = OrderAgent.save(order1)

      order2 = build(:order)
      {:ok, order2_uuid} = OrderAgent.save(order2)

      response = Report.create(filename)
      expected_response = {:ok, "Report successfully created"}

      assert response == expected_response

      report_content = File.read!("#{filename}.csv")

      assert String.contains?(report_content, [
               order1.user_cpf,
               order2.user_cpf,
               order1_uuid,
               order2_uuid
             ]) == true
    end

    test "if the file extension is specified, returns an error" do
      filename = "report_test.csv"

      assert Report.create(filename) == {:error, "Filename should not contain file extension"}
    end
  end
end
