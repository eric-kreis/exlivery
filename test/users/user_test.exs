defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  @params %{
    name: "Eric Kreis",
    email: "ericalfinitokreis@gmail.com",
    cpf: "12345678900",
    age: 20,
    address: "Brasília, DF"
  }

  describe "build/5" do
    test "when params are valid, returns the user" do
      response =
        User.build(@params.name, @params.email, @params.cpf, @params.age, @params.address)

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when age is less than 18, returns an error" do
      response = User.build(@params.name, @params.email, @cpf, 17, @params.address)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when cpf is not a string, returns an error" do
      response =
        User.build(@params.name, @params.email, 12_345_678_900, @params.age, @params.address)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
