defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent

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
      user = build(:user)
      {:ok, cpf} = UserAgent.save(user)

      {:ok, cpf: cpf, user: user}
    end

    test "when the user exists, returns the user", %{cpf: cpf, user: user} do
      response = UserAgent.get(cpf)

      expected_response = {:ok, user}

      assert response == expected_response
    end

    test "when the user was not found, return an error" do
      response = UserAgent.get("000000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
