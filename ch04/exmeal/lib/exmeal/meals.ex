defmodule Exmeal.Meals do
  alias Exmeal.Repo
  alias Exmeal.Error
  alias Exmeal.Meals.Meal

  def create(attrs) do
    %Meal{}
    |> Meal.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, %Meal{}} = result -> result
      {:error, changeset} -> {:error, Error.build(:bad_request, changeset)}
    end
  end

  def by_id(meal_uuid) do
    case Repo.get(Meal, meal_uuid) do
      nil -> {:error, Error.build(:not_found, "Meal not found.")}
      %Meal{} = meal -> {:ok, meal}
    end
  end

  def update(%{"id" => uuid} = attrs) do
    case by_id(uuid) do
      {:ok, meal} ->
        meal
        |> Meal.changeset(attrs)
        |> Repo.update()

      reply ->
        reply
    end
  end

  def delete_by_id(meal_uuid) do
    case by_id(meal_uuid) do
      {:ok, meal} -> Repo.delete(meal)
      reply -> reply
    end
  end
end
