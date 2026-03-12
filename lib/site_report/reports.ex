defmodule SiteReport.Reports do
  @moduledoc """
  The Reports context.
  """

  import Ecto.Query, warn: false

  alias SiteReport.Repo
  alias SiteReport.Reports.DailyReport

  def list_daily_reports do
    DailyReport
    |> order_by([daily_report], desc: daily_report.date, desc: daily_report.inserted_at)
    |> Repo.all()
  end

  def get_daily_report!(id), do: Repo.get!(DailyReport, id)

  def create_daily_report(attrs \\ %{}) do
    %DailyReport{}
    |> DailyReport.changeset(attrs)
    |> Repo.insert()
  end
end
