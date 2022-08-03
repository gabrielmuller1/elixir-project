defmodule Flightex.Users.User do
  @keys [:name, :email, :cpf, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(_name, _email, cpf) when not is_binary(cpf), do: {:error, "Cpf must be a String"}

  def build(name, email, cpf) do
    {:ok, %__MODULE__{id: UUID.uuid4(), name: name, email: email, cpf: cpf}}
  end
end
