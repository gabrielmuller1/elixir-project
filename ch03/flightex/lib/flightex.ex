defmodule Flightex do
  alias Flightex.Bookings.CreateOrUpdate
  alias Flightex.Users.Agent, as: UsersAgent
  alias Flightex.Bookings.Agent, as: BookingsAgent

  def start_agents do
    UsersAgent.start_link(%{})
    BookingsAgent.start_link(%{})
  end

  defdelegate create_or_update_booking(params), to: CreateOrUpdate, as: :call
end
