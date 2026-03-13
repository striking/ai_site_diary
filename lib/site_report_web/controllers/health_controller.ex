defmodule SiteReportWeb.HealthController do
  use SiteReportWeb, :controller

  def index(conn, _params) do
    json(conn, %{status: "ok"})
  end
end
