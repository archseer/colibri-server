defmodule Colibri.Repo.Migrations.CreateTrack do
  use Ecto.Migration

  def change do
    create table(:tracks) do
      add :title, :string
      add :duration, :integer
      add :disc, :integer
      add :filename, :string

      add :album_id, references(:albums)

      timestamps
    end

  end
end
