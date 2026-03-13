defmodule SiteReport.Reports.DailyReport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daily_reports" do
    field :date, :date
    field :summary, :string
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  def changeset(daily_report, attrs) do
    daily_report
    |> cast(attrs, [:title, :summary, :date])
    |> validate_required([:title, :summary, :date])
  end
end
