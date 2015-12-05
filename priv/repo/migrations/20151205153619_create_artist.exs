defmodule Colibri.Repo.Migrations.CreateArtist do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add :name, :string

      timestamps
    end

    alter table(:tracks) do
      add :artist_id, references(:artists)
    end
    alter table(:albums) do
      remove :artist
      add :artist_id, references(:artists)
    end

  end
end
