defmodule Ticketapp.Repo do
  use Ecto.Repo,
    otp_app: :ticketapp,
    adapter: Ecto.Adapters.Postgres
end
