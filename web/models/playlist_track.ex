defmodule Colibri.PlaylistTrack do
  @moduledoc """
  Join table for playlist contents.
  """
  use Colibri.Web, :model

  schema "playlist_tracks" do
    belongs_to :track, Colibri.Track
    belongs_to :playlist, Colibri.Playlist
  end

  @required_fields ~w(track_id playlist_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ {}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
