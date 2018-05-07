# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :contract_manager, ecto_repos: [ContractManager.Repo]

# Configures the endpoint
config :contract_manager, ContractManagerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7CWt2BOC1zrseKbSQEMcfiiu7C7TQNWv7/G5aLjGogznkdeiXsGto0oxwDeIxVWD",
  render_errors: [view: ContractManagerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ContractManager.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :format_encoders, json: Jason

config :contract_manager, ContractManagerWeb.AuthAccessPipeline,
  module: ContractManagerWeb.Guardian,
  error_handler: ContractManager.AuthErrorHandler

config :mime, :types, %{
  "application/xml" => ["xml"]
}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
