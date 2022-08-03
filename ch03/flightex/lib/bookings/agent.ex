defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_link(_init_arg), do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%Booking{id: uuid} = booking) do
    Agent.update(__MODULE__, &update_state(&1, booking))
    {:ok, uuid}
  end

  def get(uuid), do: Agent.get(__MODULE__, &get_booking(&1, uuid))

  def list_all(), do: Agent.get(__MODULE__, & &1)

  defp get_booking(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end

  defp update_state(state, %Booking{id: uuid} = booking), do: Map.put(state, uuid, booking)
end
