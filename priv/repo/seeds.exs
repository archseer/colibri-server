# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Colibri.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

artist = Colibri.Repo.insert!(%Colibri.Artist{name: "fox capture plan"})

album = Ecto.build_assoc(artist, :albums, title: "Butterfly")
album = Colibri.Repo.insert!(album)


data = [
  %{title: "The Beginning Of", duration: 68},
  %{title: "The Last Story of the Myth", duration: 188}
]

data |> Enum.each fn x ->
  data = x |> Map.merge(%{filename: "a", artist_id: artist.id})
  track = Ecto.build_assoc(album, :tracks, data)
  Colibri.Repo.insert!(track)
end
