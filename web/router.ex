defmodule Colibri.Router do
  use Colibri.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug Corsica, origins: "*", allow_headers: ["accept", "content-type"]
  end

  scope "/", Colibri do
    pipe_through :api

    get "/", PageController, :index

    resources "/artists", ArtistController, except: [:new, :edit] do
      resources "/albums", AlbumController, only: [:index]
    end
    resources "/tracks", TrackController, only: [:show]
    resources "/albums", AlbumController, except: [:new, :edit] do
      resources "/tracks", TrackController, except: [:new, :edit]
    end
  end
end
