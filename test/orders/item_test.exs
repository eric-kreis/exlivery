defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  @params %{
    description: "Pepperoni pizza",
    category: :pizza,
    unity_price: 35.5,
    quantity: 2
  }

  describe "build/4" do
    test "when params are valid, returns the item" do
      response =
        Item.build(
          @params.description,
          @params.category,
          @params.unity_price,
          @params.quantity
        )

      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "when there is an invalid category, returns an error" do
      response =
        Item.build(
          @params.description,
          :banana,
          @params.unity_price,
          @params.quantity
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when there is an invalid price, returns an error" do
      response =
        Item.build(
          @params.description,
          @params.category,
          "banana",
          @params.quantity
        )

      expected_response = {:error, "Invalid price"}

      assert response == expected_response
    end

    test "when there is an invalid quantity, returns an error" do
      response =
        Item.build(
          @params.description,
          @params.category,
          @params.unity_price,
          0
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
