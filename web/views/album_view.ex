defmodule Colibri.AlbumView do
  use Colibri.Web, :view

  location "/albums/:id"
  attributes [:title, :cover]

  has_one :artist,
    serializer: Colibri.ArtistView,
    include: true

  has_many :tracks,
    link: "/albums/:id/tracks"

end
