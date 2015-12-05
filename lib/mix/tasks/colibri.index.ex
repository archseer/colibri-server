defmodule Mix.Tasks.Colibri.Index do
  use Mix.Task

  alias Colibri.Track

  @shortdoc "Indexes the music library into Ecto."

  def run(args) do
    command = "ruby scanner.rb"
    #{:cd, path},
    port = Port.open({:spawn, command}, [:stream, :binary, {:line, 1000000}, :exit_status])
    handle_port(port)
  end

  def handle_port(port) do
    receive do
      {^port, {:data, {:eol, result}}} ->
        {:ok, data} = JSX.decode(result)
        create_track(data)
        handle_port(port)
      {^port, {:exit_status, _status}} ->
        IO.puts("Stopped procesing!")
    end
  end

  def create_track(data) do
    changeset = Track.changeset(%Track{}, data)
    case Repo.insert(changeset) do
      {:ok, _track} ->
        IO.puts "Created!"
      {:error, changeset} ->
        IO.puts(inspect changeset.errors)
    end
  end
end
