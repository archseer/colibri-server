# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :colibri, Colibri.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "POeGwVamCxRomglQI+rOzEqbo30sWbyX6auoFb0dfy9Qzs6zP/vvpUmOxseiR/BW",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Colibri.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :phoenix, :format_encoders,
  "json-api": Poison

config :plug, :mimes, %{
  "application/vnd.api+json" => ["json-api"]
}

config :guardian, Guardian,
  issuer: "Colibri",
  ttl: {30, :days},
  verify_issuer: true,
  secret_key: 'cQou3GD1KL4LFz2r01tlQDWZQh3gqvJ6nOu4PRnajnaxPyE5hgMtPzPOHhT0kt2g',
  serializer: Colibri.GuardianSerializer
