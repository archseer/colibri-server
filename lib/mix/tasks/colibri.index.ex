defmodule Mix.Tasks.Colibri.Index do
  use Mix.Task

  alias Colibri.Track

  @shortdoc "Indexes the music library into Ecto."

  def run(args) do
    Mix.Task.run "app.start", []
    command = "ruby scanner.rb"
    port = Port.open({:spawn, command}, [:stream, :binary, {:line, 1000000}, :exit_status])
    handle_port(port)
  end

  def handle_port(port) do
    receive do
      {^port, {:data, {:eol, result}}} ->
        IO.puts(result)
        {:ok, data} = JSX.decode(result)
        create_track(data)
        handle_port(port)
      {^port, {:exit_status, _status}} ->
        IO.puts("Stopped procesing!")
    end
  end

  def create_track(data) do
    data = data
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{}, fn {key, val} -> {String.to_atom(key), val} end)

    album = data.album
    |> Colibri.Album.find_or_create(data.albumartist |> Colibri.Artist.find_or_create)

    unless album.cover, do: data |> Track.cover |> set_coverart(album)

    data
    |> Map.put(:album_id, album.id)
    |> Map.put(:artist_id, Colibri.Artist.find_or_create(data.artist).id)
    |> insert_track
  end

  def insert_track(data) do
    c = Track.changeset(%Track{}, data)
    case Colibri.Repo.insert(c) do
      {:ok, track} ->
        IO.puts "Created #{track.title}"
      {:error, changeset} ->
        IO.puts(inspect changeset.errors)
    end
  end

  def set_coverart(cover, album), do: nil
  def set_coverart(cover, album) do
    album
    |> Colibri.Album.changeset(%{cover: cover})
    |> Colibri.Repo.update!
  end
end
