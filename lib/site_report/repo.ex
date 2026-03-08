defmodule SiteReport.Repo do
  use Ecto.Repo,
    otp_app: :site_report,
    adapter: Ecto.Adapters.Postgres
end
