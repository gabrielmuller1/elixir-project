defmodule Exlivery.Users.CreateOrUpdate do
  alias Exlivery.Users.User
  alias Exlivery.Users.Agent, as: UserAgent

  def call(%{name: name, email: email, tax_id: tax_id, age: age, address: address}) do
    name
    |> User.build(email, tax_id, age, address)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}), do: UserAgent.save(user)
  defp save_user({:error, _reason} = error), do: error
end
