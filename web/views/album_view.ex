defmodule Colibri.AlbumView do
  use Colibri.Web, :view

  location "/albums/:id"
  attributes [:title]

  has_one :artist,
    serializer: Colibri.ArtistView,
    include: true

  has_many :tracks,
    serializer: Colibri.TrackView,
    link: "/albums/:id/tracks"
end
