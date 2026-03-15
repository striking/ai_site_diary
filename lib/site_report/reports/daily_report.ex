defmodule SiteReport.Reports.DailyReport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daily_reports" do
    field :date, :date
    field :summary, :string
    field :title, :string
    field :description, :string, virtual: true

    timestamps(type: :utc_datetime)
  end

  def changeset(daily_report, attrs) do
    daily_report
    |> cast(attrs, [:title, :summary, :date])
    |> validate_required([:title, :summary, :date])
  end

  def description_changeset(daily_report, attrs) do
    daily_report
    |> cast(attrs, [:description])
    |> validate_required([:description])
  end
end
