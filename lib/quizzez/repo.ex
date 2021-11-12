defmodule Quizzez.Repo do
  use Ecto.Repo,
    otp_app: :quizzez,
    adapter: Ecto.Adapters.Postgres
end
