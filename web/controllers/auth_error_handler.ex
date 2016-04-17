defmodule Colibri.AuthErrorHandler do
  use Colibri.Web, :controller

  def unauthenticated(conn, _params) do
    conn
    |> json(%{"errors" => ["You must be an authenticated user to view this resource!"]})
    |> halt
  end
end
