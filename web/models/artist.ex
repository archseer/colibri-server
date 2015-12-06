defmodule Colibri.Artist do
  use Colibri.Web, :model

  alias __MODULE__
  alias Colibri.Repo

  schema "artists" do
    field :name, :string

    has_many :tracks, Colibri.Track
    has_many :albums, Colibri.Album

    timestamps
  end

  @required_fields ~w(name)
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

  def find_or_create(name) do
    if artist = Colibri.Repo.one(from a in Colibri.Artist, where: a.name == ^name) do
      artist
    else
      Artist.changeset(%Artist{}, %{name: name})
      |> Repo.insert!
    end
  end
end
