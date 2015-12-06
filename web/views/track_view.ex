defmodule Colibri.TrackView do
  use Colibri.Web, :view

  #location "/tracks/:id"
  attributes [:title, :duration, :track, :disc, :filename]
end
