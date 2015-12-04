defmodule Colibri.PageController do
  use Colibri.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
