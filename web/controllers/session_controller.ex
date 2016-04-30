defmodule Colibri.SessionController do
  use Colibri.Web, :controller

  alias Colibri.User

  def create(conn, %{"username" => username, "password" => password}) do
    case Repo.get_by(User, %{username: username}) do
      nil ->
        Comeonin.Bcrypt.dummy_checkpw
        login_failed(conn)
      user ->
        if Comeonin.Bcrypt.checkpw(password, user.encrypted_password) do
          {:ok, token, _} = Guardian.encode_and_sign(user, :api)
          json(conn, %{token: token})
        else
          login_failed(conn)
        end
    end
  end

  defp login_failed(conn) do
    conn
    |> put_status(:unauthorized)
    |> json(%{errors: ["Invalid username/password combination!"]})
    |> halt
  end
end

# curl -H "Content-Type: application/json" -X POST -d '{"username":"test", "password":"test"}' http://localhost:4000/login
