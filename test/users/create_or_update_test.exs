defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  @params %{
    name: "Eric Kreis",
    email: "ericalfinitokreis@gmail.com",
    cpf: "12345678900",
    age: 20,
    address: "Brasília, DF"
  }

  describe "call/1" do
    setup do
      UserAgent.start_link()

      :ok
    end

    test "when params are valid, saves the user" do
      response = CreateOrUpdate.call(@params)

      expected_response = {:ok, @params.cpf}

      assert response == expected_response
    end

    test "when params are valid, returns an error" do
      response = CreateOrUpdate.call(%{@params | age: 17})

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
