defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent

  import Exlivery.Factory

  describe "save/1" do
    test "saves the user" do
      UserAgent.start_link()

      user = build(:user)

      assert UserAgent.save(user) == {:ok, user.cpf}
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link()

      {:ok, cpf} =
        :user
        |> build()
        |> UserAgent.save()

      {:ok, cpf: cpf}
    end

    test "when the user exists, returns the user", %{cpf: cpf} do
      response = UserAgent.get(cpf)

      expected_response =
        {:ok,
         %Exlivery.Users.User{
           address: "Brasília, DF",
           age: 20,
           cpf: cpf,
           email: "ericalfinitokreis@gmail.com",
           name: "Eric Kreis"
         }}

      assert response == expected_response
    end

    test "when the user is not foun, return an error" do
      response = UserAgent.get("000000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
