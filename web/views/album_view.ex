defmodule Colibri.AlbumView do
  use Colibri.Web, :view

  location "/albums/:id"
  attributes [:title, :artist]
end
