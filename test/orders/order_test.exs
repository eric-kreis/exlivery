defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Order

  @params %{
    user: build(:user),
    item: [
      build(:item),
      build(:item,
        description: "Temaki",
        category: :japanese,
        quantity: 2,
        unity_price: Decimal.new("22.72")
      )
    ]
  }

  describe "build/2" do
    test "when params are valid, returns the item" do
      response = Order.build(@params.user, @params.item)

      expected_response = {:ok, build(:order)}

      assert response == expected_response
    end

    test "when there is no items in the order, returns an error" do
      response = Order.build(@params.user, [])

      expected_response = {:error, "Invalid Parameters"}

      assert response == expected_response
    end
  end
end
