defmodule SiteReportWeb.ReportLive.Edit do
  use SiteReportWeb, :live_view

  alias SiteReport.Reports

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    report = Reports.get_daily_report!(id)

    {:ok,
     socket
     |> assign(:report, report)
     |> assign(:form, to_form(Reports.DailyReport.changeset(report, %{}), as: :report))}
  end

  @impl true
  def handle_event("validate", %{"report" => report_params}, socket) do
    changeset =
      socket.assigns.report
      |> Reports.DailyReport.changeset(report_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset, as: :report))}
  end

  def handle_event("save", %{"report" => report_params}, socket) do
    case Reports.update_daily_report(socket.assigns.report, report_params) do
      {:ok, report} ->
        {:noreply,
         socket
         |> assign(:report, report)
         |> push_navigate(to: ~p"/reports")}

      {:error, %Ecto.Changeset{} = changeset} ->
        changeset = Map.put(changeset, :action, :validate)
        {:noreply, assign(socket, :form, to_form(changeset, as: :report))}
    end
  end
end
