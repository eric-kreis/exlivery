defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  @name "Eric Kreis"
  @email "ericalfinitokreis@gmail.com"
  @cpf "12345678900"
  @age 20
  @address "Brasília, DF"

  describe "build/5" do
    test "when params are valid, returns the user" do
      response = User.build(@name, @email, @cpf, @age, @address)

      expected_response =
        {:ok,
         %Exlivery.Users.User{
           address: "Brasília, DF",
           age: 20,
           cpf: "12345678900",
           email: "ericalfinitokreis@gmail.com",
           name: "Eric Kreis"
         }}

      assert response == expected_response
    end

    test "when age is less than 18, returns an error" do
      response = User.build(@name, @email, @cpf, 17, @address)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when cpf is not a string, returns an error" do
      response = User.build(@name, @email, 12_345_678_900, @age, @address)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
