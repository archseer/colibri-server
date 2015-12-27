defmodule Colibri.TrackController do
  use Colibri.Web, :controller

  alias Colibri.Track

  plug :scrub_params, "track" when action in [:create, :update]

  # /album/:id/tracks
  def index(conn, %{"album_id" => album_id}) do
    tracks = assoc(%Colibri.Album{id: album_id}, :tracks)
    |> order_by([:pos, :id])
    |> Repo.all
    render(conn, :index, tracks: tracks)
  end

  # /playlist/:id/tracks
  def index(conn, %{"playlist_id" => playlist_id}) do
    tracks = Repo.all assoc(%Colibri.Playlist{id: playlist_id}, :tracks)
    render(conn, :index, tracks: tracks)
  end

  def create(conn, %{"track" => track_params}) do
    changeset = Track.changeset(%Track{}, track_params)

    case Repo.insert(changeset) do
      {:ok, track} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", track_path(conn, :show, track))
        |> render(:show, track: track)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Colibri.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    track = Repo.get!(Track, id)
    render(conn, :show, track: track)
  end

  def update(conn, %{"id" => id, "track" => track_params}) do
    track = Repo.get!(Track, id)
    changeset = Track.changeset(track, track_params)

    case Repo.update(changeset) do
      {:ok, track} ->
        render(conn, :show, track: track)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Colibri.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    track = Repo.get!(Track, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(track)

    send_resp(conn, :no_content, "")
  end
end
