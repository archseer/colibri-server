defmodule Colibri.Router do
  use Colibri.Web, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
    #plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  pipeline :auth do
    plug Guardian.Plug.EnsureAuthenticated, handler: Colibri.AuthErrorHandler
  end

  scope "/", Colibri do
    pipe_through :api
    post "/login", SessionController, :create, as: :login
  end

  scope "/", Colibri do
    pipe_through [:api, :auth]

    get "/", PageController, :index

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
