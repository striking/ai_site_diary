defmodule SiteReportWeb.DailyReportLive.Form do
  use SiteReportWeb, :live_view

  alias SiteReport.Reports
  alias SiteReport.Reports.DailyReport

  def mount(_params, _session, socket) do
    changeset = DailyReport.changeset(%DailyReport{}, %{})

    {:ok,
     socket
     |> assign(:page_title, "New Daily Report")
     |> assign_form(changeset)}
  end

  def handle_event("validate", %{"daily_report" => daily_report_params}, socket) do
    changeset =
      %DailyReport{}
      |> DailyReport.changeset(daily_report_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"daily_report" => daily_report_params}, socket) do
    case Reports.create_daily_report(daily_report_params) do
      {:ok, _daily_report} ->
        {:noreply,
         socket
         |> put_flash(:info, "Daily report submitted successfully.")
         |> push_navigate(to: ~p"/reports")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="space-y-8 rounded-3xl border border-base-300 bg-base-100/90 p-6 shadow-sm ring-1 ring-base-300/40 transition duration-200 sm:p-8">
        <.header>
          Submit daily site report
          <:subtitle>
            Capture key on-site progress, workforce, and material usage for the day.
          </:subtitle>
        </.header>

        <.back navigate={~p"/reports"}>Back to reports</.back>

        <.simple_form for={@form} id="daily-report-form" phx-change="validate" phx-submit="save">
          <div class="grid gap-4 sm:grid-cols-2">
            <.input field={@form[:date]} type="date" label="Date" required />
            <.input field={@form[:site_name]} type="text" label="Site name" required />
            <.input
              field={@form[:weather_conditions]}
              type="text"
              label="Weather conditions"
              required
            />
            <.input
              field={@form[:workers_on_site]}
              type="number"
              label="Workers on site"
              min="0"
              required
            />
          </div>

          <.input
            field={@form[:work_completed]}
            type="textarea"
            label="Work completed"
            rows="5"
            required
          />

          <div class="grid gap-4">
            <.input
              field={@form[:issues_encountered]}
              type="textarea"
              label="Issues encountered"
              rows="4"
            />

            <.input
              field={@form[:materials_used]}
              type="textarea"
              label="Materials used"
              rows="4"
            />
          </div>

          <:actions>
            <.button type="submit" variant="primary" id="submit-daily-report">
              Submit report
            </.button>
          </:actions>
        </.simple_form>
      </div>
    </Layouts.app>
    """
  end
end
