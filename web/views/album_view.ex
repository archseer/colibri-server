defmodule Colibri.AlbumView do
  use Colibri.Web, :view

  attributes [:title, :artist]

  def render("index.json", %{albums: albums}) do
    %{data: render_many(albums, Colibri.AlbumView, "album.json")}
  end

  def render("show.json", %{album: album}) do
    %{data: render_one(album, Colibri.AlbumView, "album.json")}
  end

  def render("album.json", %{album: album}) do
    %{id: album.id,
      title: album.title,
      artist: album.artist}
  end
end
