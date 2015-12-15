defmodule Colibri.PlaylistTrackTest do
  use Colibri.ModelCase

  alias Colibri.PlaylistTrack

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PlaylistTrack.changeset(%PlaylistTrack{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PlaylistTrack.changeset(%PlaylistTrack{}, @invalid_attrs)
    refute changeset.valid?
  end
end
