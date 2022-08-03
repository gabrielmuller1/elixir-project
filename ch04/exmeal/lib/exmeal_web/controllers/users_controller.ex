defmodule ExmealWeb.UsersController do
  use ExmealWeb, :controller

  alias Exmeal.Users

  action_fallback ExmealWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def update(conn, params) do
    with {:ok, user} <- Users.update_user_by_id(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def show(conn, %{"id" => id} = _params) do
    with {:ok, user} <- Users.user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _user} <- Users.delete_user_by_id(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
