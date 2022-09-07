defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent

  describe "save/1" do
    test "saves the order" do
      OrderAgent.start_link()

      order = build(:order)

      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link()
      order = build(:order)
      {:ok, uuid} = OrderAgent.save(order)

      {:ok, uuid: uuid, order: order}
    end

    test "when the user exists, returns the order", %{uuid: uuid, order: order} do
      response = OrderAgent.get(uuid)

      expected_response = {:ok, order}

      assert response == expected_response
    end

    test "when the order was not found, return an error" do
      response = OrderAgent.get(UUID.uuid4())

      expected_response = {:error, "Order not found"}

      assert response == expected_response
    end
  end
end
