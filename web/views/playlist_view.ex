defmodule Colibri.PlaylistView do
  use Colibri.Web, :view

  location "/playlists/:id"
  attributes [:title]

  has_many :tracks,
  link: "/playlists/:id/tracks"
end
