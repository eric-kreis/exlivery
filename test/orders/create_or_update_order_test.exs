defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Exlivery.start_agents()
      user = build(:user)
      UserAgent.save(user)
      cpf = user.cpf
      item1 = build(:item)

      item2 =
        build(
          :item,
          description: "Açaí with banana",
          category: :dessert,
          unity_price: "22.5",
          quantity: 2
        )

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "when params are valid, saves the order", %{
      user_cpf: user_cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: user_cpf, items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "when params there is no user, returns an error", %{item1: item1, item2: item2} do
      params = %{user_cpf: "00000000000", items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end

    test "when params there are invalid items, returns an error", %{
      user_cpf: user_cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: user_cpf, items: [%{item1 | quantity: 0}, item2]}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid Items"}

      assert response == expected_response
    end

    test "when there is no items, returns an error", %{user_cpf: user_cpf} do
      params = %{user_cpf: user_cpf, items: []}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid Parameters"}

      assert response == expected_response
    end
  end
end
