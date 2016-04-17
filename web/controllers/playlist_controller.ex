defmodule Colibri.PlaylistController do
  use Colibri.Web, :controller

  alias Colibri.Playlist
  alias Colibri.PlaylistTrack

  # plug :scrub_params, "playlist" when action in [:create, :update]

  def index(conn, _params) do
    playlists = Repo.all(Playlist)
    render(conn, :index, data: playlists)
  end

  def create(conn, %{"data" => %{"attributes" => playlist_params, "type" => "playlists"}}) do
    changeset = Playlist.changeset(%Playlist{}, playlist_params)

    case Repo.insert(changeset) do
      {:ok, playlist} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", playlist_path(conn, :show, playlist))
        |> render(:show, data: playlist)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Colibri.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    playlist = Repo.get!(Playlist, id)
    render(conn, :show, data: playlist)
  end

  def update(conn, %{"id" => id, "data" => %{"attributes" => playlist_params,
                                             "relationships" => %{"tracks" => %{"data" => tracks}},
                                             "type" => "playlists"}}) do
    playlist = Repo.get!(Playlist, id)
    changeset = Playlist.changeset(playlist, playlist_params)

    resp = Repo.transaction fn ->
      p = Repo.update!(changeset)
      # remove all tracks
      PlaylistTrack
      |> where(playlist_id: ^playlist.id)
      |> Repo.delete_all
      # (re-)insert tracks
      tracks |> Enum.each(&Playlist.add_track(playlist, &1))
      p
    end

    case resp do
      {:ok, playlist} ->
        render(conn, :show, data: playlist)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Colibri.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    playlist = Repo.get!(Playlist, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(playlist)

    send_resp(conn, :no_content, "")
  end
end
