defmodule SiteReportWeb.ReportLive.New do
  use SiteReportWeb, :live_view

  alias SiteReport.Reports
  alias SiteReport.Reports.DailyReport

  @impl true
  def mount(_params, _session, socket) do
    changeset = DailyReport.changeset(%DailyReport{}, %{})

    {:ok,
     socket
     |> assign(:form, to_form(changeset, as: :report))}
  end

  @impl true
  def handle_event("validate", %{"report" => report_params}, socket) do
    changeset =
      %DailyReport{}
      |> DailyReport.changeset(report_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset, as: :report))}
  end

  def handle_event("save", %{"report" => report_params}, socket) do
    case Reports.create_daily_report(report_params) do
      {:ok, _report} ->
        {:noreply, push_navigate(socket, to: ~p"/reports")}

      {:error, %Ecto.Changeset{} = changeset} ->
        changeset = Map.put(changeset, :action, :validate)
        {:noreply, assign(socket, :form, to_form(changeset, as: :report))}
    end
  end
end
