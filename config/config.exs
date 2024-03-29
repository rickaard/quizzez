# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :quizzez,
  ecto_repos: [Quizzez.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :quizzez, QuizzezWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: QuizzezWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Quizzez.PubSub,
  live_view: [signing_salt: "fSEOc+PH"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :quizzez, Quizzez.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [default_scope: "email profile"]},
    identity:
      {Ueberauth.Strategy.Identity,
       [
         callback_methods: ["POST"],
         param_nesting: "user",
         request_path: "/register",
         callback_path: "register"
       ]}
  ]

config :quizzez, QuizzezWeb.Authentication,
  issuer: "quizzez",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY") || "mysupersecretkey"

# Tailwind
config :tailwind,
  version: "3.1.8",
  default: [
    args: ~w(
    --config=tailwind.config.js
    --input=css/app.css
    --output=../priv/static/assets/app.css
  ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
