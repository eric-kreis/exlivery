defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
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

  def order_factory do
    %Order{
      delivery_address: "Brasília, DF",
      items: [
        build(:item),
        build(:item,
          description: "Temaki",
          category: :japanese,
          quantity: 2,
          unity_price: Decimal.new("22.72")
        )
      ],
      total_price: Decimal.new("116.44"),
      user_cpf: "12345678900"
    }
  end
end
