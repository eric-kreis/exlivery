defmodule Exlivery.Users.Agent do
  use Agent

  alias Exlivery.Users.User

  def start_link(), do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%User{} = user), do: Agent.update(__MODULE__, &update_state(&1, user))

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  defp get_user(state, cpf) when is_map_key(state, cpf), do: {:error, "User not found"}

  defp get_user(state, cpf), do: {:ok, Map.get(state, cpf)}

  defp update_state(state, %User{cpf: cpf} = user), do: Map.put(state, cpf, user)
end
