# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :authorization_with_pow,
  ecto_repos: [AuthorizationWithPow.Repo]

# Configures the endpoint
config :authorization_with_pow, AuthorizationWithPowWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DgkhGfSoicZk6udpOOidYxNjZFWUtUeDvPUdKJZQ4tHTebV7/UPkbbUT6AYd94eJ",
  render_errors: [view: AuthorizationWithPowWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: AuthorizationWithPow.PubSub,
  live_view: [signing_salt: "LOf3BIy8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :authorization_with_pow, :pow,
  user: AuthorizationWithPow.Users.User,
  repo: AuthorizationWithPow.Repo,
  extensions: [PowPersistentSession],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  web_module: AuthorizationWithPowWeb,
  messages_backend: AuthorizationWithPowWeb.Pow.Messages

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
