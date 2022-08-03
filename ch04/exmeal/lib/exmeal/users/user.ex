defmodule Exmeal.Users.User do
  use Exmeal.Schema

  alias Exmeal.Meals.Meal
  @fields [:name, :tax_id, :email]

  @derive {Jason.Encoder, only: [:id] ++ @fields}

  schema "users" do
    field(:name, :string)
    field(:tax_id, :string)
    field(:email, :string)

    has_many(:meals, Meal)

    timestamps()
  end

  def changeset(%__MODULE__{} = meal, attrs) do
    meal
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint([:tax_id])
    |> unique_constraint([:email])
  end
end
