defmodule Exmeal.Users do
  alias Exmeal.Repo
  alias Exmeal.Error
  alias Exmeal.Users.User

  def create(attrs) do
    case User.changeset(%User{}, attrs) |> Repo.insert() do
      {:ok, %User{}} = result ->
        result

      {:error, result} ->
        {:error, Error.build(:bad_request, result)}
    end
  end

  def user_by_id(user_uuid) do
    case Repo.get(User, user_uuid) do
      nil -> {:error, Error.build(:not_found, "User not found.")}
      user -> {:ok, user}
    end
  end

  def delete_user_by_id(user_uuid) do
    case user_by_id(user_uuid) do
      {:ok, user} -> Repo.delete(user)
      reply -> reply
    end
  end

  def update_user_by_id(%{"id" => user_uuid} = params) do
    case user_by_id(user_uuid) do
      {:ok, user} ->
        user
        |> User.changeset(params)
        |> Repo.update()

      reply ->
        reply
    end
  end
end
