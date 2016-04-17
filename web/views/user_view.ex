defmodule Colibri.UserView do
  use Colibri.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Colibri.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Colibri.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      encrypted_password: user.encrypted_password}
  end
end
