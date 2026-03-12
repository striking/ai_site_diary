defmodule SiteReportWeb.ReportLive.Index do
  use SiteReportWeb, :live_view

  alias SiteReport.Reports
  alias SiteReport.Reports.DailyReport

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Daily reports")
     |> assign(:daily_reports, Reports.list_daily_reports())
     |> assign_form(Reports.change_daily_report(%DailyReport{}))}
  end

  @impl true
  def handle_event("validate", %{"daily_report" => daily_report_params}, socket) do
    changeset =
      %DailyReport{}
      |> Reports.change_daily_report(daily_report_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  @impl true
  def handle_event("save", %{"daily_report" => daily_report_params}, socket) do
    case Reports.create_daily_report(daily_report_params) do
      {:ok, _daily_report} ->
        {:noreply,
         socket
         |> put_flash(:info, "Daily report created successfully.")
         |> assign(:daily_reports, Reports.list_daily_reports())
         |> assign_form(Reports.change_daily_report(%DailyReport{}))}

      {:error, changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
