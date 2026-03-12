defmodule SiteReportWeb.ReportLive.Index do
  use SiteReportWeb, :live_view

  alias SiteReport.Reports
  alias SiteReport.Reports.DailyReport

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Daily reports")
     |> assign(:reports, Reports.list_daily_reports())
     |> assign_form(Reports.change_daily_report(%DailyReport{}))
     |> assign(:editing_report, nil)}
  end

  @impl true
  def handle_event("validate", %{"daily_report" => daily_report_params}, socket) do
    changeset =
      %DailyReport{}
      |> Reports.change_daily_report(daily_report_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"daily_report" => daily_report_params}, socket) do
    case Reports.create_daily_report(daily_report_params) do
      {:ok, _daily_report} ->
        {:noreply,
         socket
         |> put_flash(:info, "Daily report created successfully.")
         |> assign(:reports, Reports.list_daily_reports())
         |> assign_form(Reports.change_daily_report(%DailyReport{}))}

      {:error, changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  def handle_event("edit", %{"id" => id}, socket) do
    daily_report = Reports.get_daily_report!(id)

    {:noreply,
     socket
     |> assign(:editing_report, daily_report)
     |> assign(:page_title, "Edit daily report")
     |> assign_form(Reports.change_daily_report(daily_report))}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    daily_report = Reports.get_daily_report!(id)

    {:ok, _daily_report} = Reports.delete_daily_report(daily_report)

    socket =
      socket
      |> put_flash(:info, "Daily report deleted successfully.")
      |> assign(:reports, Reports.list_daily_reports())

    socket =
      if socket.assigns.editing_report && socket.assigns.editing_report.id == daily_report.id do
        socket
        |> assign(:editing_report, nil)
        |> assign(:page_title, "Daily reports")
        |> assign_form(Reports.change_daily_report(%DailyReport{}))
      else
        socket
      end

    {:noreply, socket}
  end

  def handle_event("validate_edit", %{"daily_report" => daily_report_params}, socket) do
    changeset =
      socket.assigns.editing_report
      |> Reports.change_daily_report(daily_report_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("update", %{"daily_report" => daily_report_params}, socket) do
    case Reports.update_daily_report(socket.assigns.editing_report, daily_report_params) do
      {:ok, _daily_report} ->
        {:noreply,
         socket
         |> put_flash(:info, "Daily report updated successfully.")
         |> assign(:reports, Reports.list_daily_reports())
         |> assign(:editing_report, nil)
         |> assign(:page_title, "Daily reports")
         |> assign_form(Reports.change_daily_report(%DailyReport{}))}

      {:error, changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  def handle_event("cancel_edit", _params, socket) do
    {:noreply,
     socket
     |> assign(:editing_report, nil)
     |> assign(:page_title, "Daily reports")
     |> assign_form(Reports.change_daily_report(%DailyReport{}))}
  end

  defp assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
