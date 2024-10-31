defmodule DistributedApi.Repo do
  use Ecto.Repo,
    otp_app: :distributed_api,
    adapter: Ecto.Adapters.Postgres
end
