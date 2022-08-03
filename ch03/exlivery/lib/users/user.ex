defmodule Exlivery.Users.User do
  @keys [:name, :email, :tax_id, :age, :address]
  @enforce_keys @keys

  defstruct @keys

  def build(name, email, tax_id, age, address) when age >= 18 do
    {:ok, %__MODULE__{name: name, email: email, tax_id: tax_id, age: age, address: address}}
  end

  def build(_name, _email, _tax_id, _age, _address), do: {:error, :invalid_parameters}
end
