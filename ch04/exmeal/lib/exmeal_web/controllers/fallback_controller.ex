defmodule ExmealWeb.FallbackController do
  use ExmealWeb, :controller

  alias Exmeal.Error
  alias ExmealWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
