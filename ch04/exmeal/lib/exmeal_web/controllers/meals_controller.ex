defmodule ExmealWeb.MealsController do
  use ExmealWeb, :controller

  alias Exmeal.Meals

  action_fallback ExmealWeb.FallbackController

  def create(conn, params) do
    with {:ok, meal} <- Meals.create(params) do
      conn
      |> put_status(:created)
      |> render("create.json", meal: meal)
    end
  end

  def update(conn, params) do
    with {:ok, meal} <- Meals.update(params) do
      conn
      |> put_status(:ok)
      |> render("meal.json", meal: meal)
    end
  end

  def show(conn, %{"id" => id} = _params) do
    with {:ok, meal} <- Meals.by_id(id) do
      conn
      |> put_status(:ok)
      |> render("meal.json", meal: meal)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _meal} <- Meals.delete_by_id(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
