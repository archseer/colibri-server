defmodule Colibri.Repo.Migrations.AddTrackPos do
  use Ecto.Migration

  def change do
    alter table(:tracks) do
      add :pos, :integer
    end
  end
end
