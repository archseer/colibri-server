defmodule Colibri.Track do
  use Colibri.Web, :model

  schema "tracks" do
    field :title, :string
    field :duration, :integer
    field :disc, :integer, default: 1
    field :filename, :string

    belongs_to :album, Colibri.Album
    belongs_to :artist, Colibri.Artist

    has_many :playlist_tracks, Colibri.PlaylistTrack
    has_many :playlists, through: [:playlist_tracks, :playlist]

    timestamps
  end

  @required_fields ~w(title duration disc filename album_id artist_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def cover(track) do
    glob =
      Path.join(["priv/static", Path.dirname(track.filename)])
      |> File.cd!(fn () -> Path.wildcard("*.{jpg,jpeg,png}") end)
    case glob do
      [h | _] ->
        Path.join([Path.dirname(track.filename), h])
        |> Path.relative_to("priv/static")
      _ -> nil
    end
  end
end
