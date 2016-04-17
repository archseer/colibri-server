defmodule Colibri.User do
  use Colibri.Web, :model

  schema "users" do
    field :username, :string
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    timestamps
  end

  @required_fields ~w(username email)
  @optional_fields ~w(password encrypted_password)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> hash_password
  end

  defp hash_password(model) do
    case get_change(model, :password) do
      nil -> model
      password -> put_change(model, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
    end
  end
end
