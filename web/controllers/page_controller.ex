defmodule Colibri.PageController do
  use Colibri.Web, :controller

  def index(conn, _params) do
    conn
    |> put_status(200)
    |> text("hi!")
  end
end
