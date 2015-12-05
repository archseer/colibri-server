defmodule Colibri.Track do
  use Colibri.Web, :model

  schema "tracks" do
    field :title, :string
    field :duration, :integer
    field :disc, :integer
    field :filename, :string

    belongs_to :album, Colibri.Album
    belongs_to :artist, Colibri.Artist

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
end
