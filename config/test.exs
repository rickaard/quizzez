import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :quizzez, Quizzez.Repo,
  username: "postgres",
  password: "password",
  database: "quizzez_db_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  port: 5432

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :quizzez, QuizzezWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "MvlxHGp/2j1tRFkDkzHd7Qnoj/8wiNU4tLNBOcJSugIWSsP5D8HRuXxwv5z+6K3X",
  server: false

# In test we don't send emails.
config :quizzez, Quizzez.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
