defmodule Colibri.ArtistView do
  use Colibri.Web, :view

  location "/artists/:id"
  attributes [:name]

  has_many :albums,
    link: "/artists/:id/albums"
end
