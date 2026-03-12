defmodule SiteReportWeb.DailyReportLive.Index do
  use SiteReportWeb, :live_view

  alias SiteReport.Reports

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :daily_reports, Reports.list_daily_reports())}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="space-y-8 rounded-3xl border border-base-300 bg-base-100/90 p-6 shadow-sm ring-1 ring-base-300/40 transition duration-200 sm:p-8">
        <.header>
          Daily reports
          <:subtitle>
            Review submitted site activity and create new end-of-day progress updates.
          </:subtitle>
          <:actions>
            <.button navigate={~p"/reports/new"} variant="primary" id="new-daily-report">
              New report
            </.button>
          </:actions>
        </.header>

        <div
          :if={@daily_reports == []}
          class="rounded-2xl border border-dashed border-base-300 bg-base-200/40 px-6 py-10 text-center text-sm text-base-content/70"
        >
          No daily reports have been submitted yet.
        </div>

        <div
          :if={@daily_reports != []}
          class="overflow-x-auto rounded-2xl border border-base-300 bg-base-100"
        >
          <.table id="daily-reports" rows={@daily_reports}>
            <:col :let={report} label="Date">{report.date}</:col>
            <:col :let={report} label="Site">{report.site_name}</:col>
            <:col :let={report} label="Weather">{report.weather_conditions}</:col>
            <:col :let={report} label="Workers">{report.workers_on_site}</:col>
            <:col :let={report} label="Work completed">{report.work_completed}</:col>
          </.table>
        </div>
      </div>
    </Layouts.app>
    """
  end
end
