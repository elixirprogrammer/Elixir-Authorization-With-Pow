defmodule AuthorizationWithPow.Repo do
  use Ecto.Repo,
    otp_app: :authorization_with_pow,
    adapter: Ecto.Adapters.Postgres
end
