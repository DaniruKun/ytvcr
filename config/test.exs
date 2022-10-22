import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ytvcr, Ytvcr.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ytvcr_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ytvcr, YtvcrWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "jL+Bjh1PTtWlvTjeidbAc9tCR2YFMGRT3y7DQYn6xGxXk3zIV8nBi4sferr56sex",
  server: false

# In test we don't send emails.
config :ytvcr, Ytvcr.Mailer, adapter: Swoosh.Adapters.Test

config :ytvcr, Oban, testing: :inline

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
