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
      |> Enum.into(%{})

    album = Colibri.Album.find_or_create(
      data["album"],
      Colibri.Artist.find_or_create(data["albumartist"])
    )
    set_coverart(album, data) unless album.cover

    data = data
      |> Map.put("album_id", album.id)
      |> Map.put("artist_id", Colibri.Artist.find_or_create(data["artist"]).id)

    changeset = Track.changeset(%Track{}, data)
    case Colibri.Repo.insert(changeset) do
      {:ok, track} ->
        IO.puts "Created #{track.title}"
      {:error, changeset} ->
        IO.puts(inspect changeset.errors)
    end
  end
end
