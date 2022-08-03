defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.User
  alias Flightex.Users.Agent, as: UserAgent

  def call(%{name: name, email: email, cpf: cpf}) do
    case User.build(name, email, cpf) do
      {:ok, user} -> UserAgent.save(user)
      reply -> reply
    end
  end
end
