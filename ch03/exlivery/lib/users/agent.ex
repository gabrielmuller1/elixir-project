defmodule Exlivery.Users.Agent do
  use Agent

  alias Exlivery.Users.User

  def start_link(_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user), do: Agent.update(__MODULE__, &update_state(&1, user))

  def get(tax_id), do: Agent.get(__MODULE__, &get_user(&1, tax_id))

  defp get_user(state, tax_id) do
    case Map.get(state, tax_id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  defp update_state(state, %User{tax_id: tax_id} = user), do: Map.put(state, tax_id, user)
end
