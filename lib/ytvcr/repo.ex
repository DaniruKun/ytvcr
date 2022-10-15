defmodule Ytvcr.Repo do
  use Ecto.Repo,
    otp_app: :ytvcr,
    adapter: Ecto.Adapters.Postgres
end
