defmodule Colibri.Router do
  use Colibri.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug Corsica, origins: "*", allow_headers: ["accept", "content-type"]
  end

  scope "/", Colibri do
    pipe_through :api

    get "/", PageController, :index

    resources "/albums", AlbumController, except: [:new, :edit]
  end
end
