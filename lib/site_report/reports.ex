defmodule SiteReport.Reports do
  @moduledoc """
  The Reports context.
  """

  alias SiteReport.Repo
  alias SiteReport.Reports.DailyReport

  def list_daily_reports do
    Repo.all(DailyReport)
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
end
