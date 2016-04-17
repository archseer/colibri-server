defmodule Colibri.Router do
  use Colibri.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/", Colibri do
    pipe_through :api

    get "/", PageController, :index

    post "/login", SessionController, :create, as: :login

    resources "/users", UserController, except: [:new, :edit]

    resources "/artists", ArtistController, except: [:new, :edit] do
      resources "/albums", AlbumController, only: [:index]
    end
    resources "/tracks", TrackController, only: [:show]
    resources "/albums", AlbumController, except: [:new, :edit] do
      resources "/tracks", TrackController, except: [:new, :edit]
    end
    resources "/playlists", PlaylistController, except: [:new, :edit] do
      resources "/tracks", TrackController, only: [:index]
    end
  end
end
