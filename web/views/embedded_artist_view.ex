defmodule Colibri.EmbeddedArtistView do
  use Colibri.Web, :view

  location "/artists/:id"
  attributes [:name]
  def type, do: "artist"
end
