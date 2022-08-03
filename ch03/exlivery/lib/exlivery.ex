defmodule Exlivery do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Orders.Agent, as: OrderAgent

  def start_agents do
    UserAgent.start_link(nil)
    OrderAgent.start_link(nil)
  end

  defdelegate create_or_update_user(args), to: Exlivery.Users.CreateOrUpdate, as: :call
  defdelegate create_or_update_order(args), to: Exlivery.Orders.CreateOrUpdate, as: :call
end
