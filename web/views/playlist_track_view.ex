defmodule Colibri.PlaylistTrackView do
  use Colibri.Web, :view

  def render("index.json", %{playlist_tracks: playlist_tracks}) do
    %{data: render_many(playlist_tracks, Colibri.PlaylistTrackView, "playlist_track.json")}
  end

  def render("show.json", %{playlist_track: playlist_track}) do
    %{data: render_one(playlist_track, Colibri.PlaylistTrackView, "playlist_track.json")}
  end

  def render("playlist_track.json", %{playlist_track: playlist_track}) do
    %{id: playlist_track.id}
  end
end
