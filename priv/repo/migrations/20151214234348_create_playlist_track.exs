defmodule Colibri.Repo.Migrations.CreatePlaylistTrack do
  use Ecto.Migration

  def change do
    create table(:playlist_tracks) do
      add :playlist_id, references(:playlists)
      add :track_id, references(:tracks)
    end

  end
end
