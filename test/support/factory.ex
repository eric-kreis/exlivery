defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  def user_factory do
    %User{
      name: "Eric Kreis",
      email: "ericalfinitokreis@gmail.com",
      cpf: "12345678900",
      age: 20,
      address: "Brasília, DF"
    }
  end

  def item_factory do
    %Item{
      description: "Pepperoni pizza",
      category: :pizza,
      unity_price: Decimal.new("35.5"),
      quantity: 2
    }
  end
end
