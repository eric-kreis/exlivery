defmodule Exlivery.Factory do
  use ExMachina

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
end
