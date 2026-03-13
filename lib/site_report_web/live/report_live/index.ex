defmodule SiteReportWeb.ReportLive.Index do
  use SiteReportWeb, :live_view

  alias SiteReport.Reports

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:daily_reports, Reports.list_daily_reports())}
  end
end
