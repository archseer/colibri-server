defmodule Colibri.TrackTest do
  use Colibri.ModelCase

  alias Colibri.Track

  @valid_attrs %{disc: 42, duration: 42, filename: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Track.changeset(%Track{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Track.changeset(%Track{}, @invalid_attrs)
    refute changeset.valid?
  end
end
