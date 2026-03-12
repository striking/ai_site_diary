defmodule SiteReport.Reports do
  @moduledoc """
  The Reports context.
  """

  import Ecto.Query, warn: false

  alias SiteReport.Repo
  alias SiteReport.Reports.DailyReport

  def list_daily_reports do
    Repo.all(
      from daily_report in DailyReport,
        order_by: [desc: daily_report.date, desc: daily_report.inserted_at]
    )
  end

  def get_daily_report!(id), do: Repo.get!(DailyReport, id)

  def create_daily_report(attrs \\ %{}) do
    %DailyReport{}
    |> DailyReport.changeset(attrs)
    |> Repo.insert()
  end

  def update_daily_report(%DailyReport{} = daily_report, attrs) do
    daily_report
    |> DailyReport.changeset(attrs)
    |> Repo.update()
  end

  def delete_daily_report(%DailyReport{} = daily_report) do
    Repo.delete(daily_report)
  end

  def change_daily_report(%DailyReport{} = daily_report, attrs \\ %{}) do
    DailyReport.changeset(daily_report, attrs)
  end
end
