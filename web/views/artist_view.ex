defmodule Colibri.ArtistView do
  use Colibri.Web, :view

  location "/artists/:id"
  attributes [:name]
end
