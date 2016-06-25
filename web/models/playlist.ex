defmodule Colibri.Playlist do
  use Colibri.Web, :model

  alias Colibri.PlaylistTrack

  schema "playlists" do
    field :title, :string

    has_many :playlist_tracks, Colibri.PlaylistTrack
    has_many :tracks, through: [:playlist_tracks, :track]

    timestamps
  end

  @required_fields ~w(title)
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

  def add_track(playlist, %{"id" => track_id}) do
    %PlaylistTrack{}
    |> PlaylistTrack.changeset(%{playlist_id: playlist.id, track_id: track_id})
    |> Colibri.Repo.insert!
  end
end
