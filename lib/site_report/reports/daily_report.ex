defmodule SiteReport.Reports.DailyReport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daily_reports" do
    field :site_name, :string
    field :date, :date
    field :weather, :string
    field :notes, :string
    field :workers_on_site, :integer
    field :progress_summary, :string

    timestamps()
  end

  def changeset(daily_report, attrs) do
    daily_report
    |> cast(attrs, [:site_name, :date, :weather, :notes, :workers_on_site, :progress_summary])
    |> validate_required([
      :site_name,
      :date,
      :weather,
      :notes,
      :workers_on_site,
      :progress_summary
    ])
    |> validate_number(:workers_on_site, greater_than_or_equal_to: 0)
  end
end
