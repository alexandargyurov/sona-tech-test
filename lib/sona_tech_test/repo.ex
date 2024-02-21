defmodule SonaTechTest.Repo do
  use Ecto.Repo,
    otp_app: :sona_tech_test,
    adapter: Ecto.Adapters.Postgres
end
