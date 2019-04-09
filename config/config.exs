# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :simple_chat,
  ecto_repos: [SimpleChat.Repo]

# Configures the endpoint
config :simple_chat, SimpleChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lvLnO5qYxyzdG1uB2V3GbdaD//hYV3qEuGT7RzkB8lU18xE407X8kOyT06Js/W21",
  render_errors: [view: SimpleChatWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SimpleChat.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
