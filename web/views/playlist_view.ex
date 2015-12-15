defmodule Colibri.PlaylistView do
  use Colibri.Web, :view

  def render("index.json", %{playlists: playlists}) do
    %{data: render_many(playlists, Colibri.PlaylistView, "playlist.json")}
  end

  def render("show.json", %{playlist: playlist}) do
    %{data: render_one(playlist, Colibri.PlaylistView, "playlist.json")}
  end

  def render("playlist.json", %{playlist: playlist}) do
    %{id: playlist.id,
      title: playlist.title}
  end
end
