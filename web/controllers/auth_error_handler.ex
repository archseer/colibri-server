defmodule Colibri.AuthErrorHandler do
  use Colibri.Web, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_status(:unauthorized)
    |> json(%{"errors" => ["You must be an authenticated user to view this resource!"]})
    |> halt
  end
end
