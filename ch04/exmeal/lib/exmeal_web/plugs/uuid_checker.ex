defmodule Exmeal.Plugs.UUIDChecker do
  import Plug.Conn

  alias Plug.Conn

  def init(opts), do: opts

  def call(%Conn{params: %{"id" => id}} = conn, _opts) do
    case Ecto.UUID.cast(id) do
      :error -> render_error(conn)
      {:ok, _uuid} -> conn
    end
  end

  def call(%Conn{} = conn, _opts), do: conn

  defp render_error(conn) do
    response_body = Jason.encode!(%{message: "Invalid request format."})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:bad_request, response_body)
    |> halt()
  end
end
