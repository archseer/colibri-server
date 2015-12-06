defmodule Colibri.Album do
  use Colibri.Web, :model

  alias __MODULE__
  alias Colibri.Repo

  schema "albums" do
    field :title, :string

    has_many :tracks, Colibri.Track
    belongs_to :artist, Colibri.Artist

    timestamps
  end

  @required_fields ~w(title artist_id)
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

  def find_or_create(title, artist) do
    if album = Repo.one(
      from a in Album,
      where: a.title == ^title and a.artist_id == ^artist.id) do
        album
    else
      Album.changeset(%Album{}, %{title: title, artist_id: artist.id})
      |> Repo.insert!
    end
  end
end
