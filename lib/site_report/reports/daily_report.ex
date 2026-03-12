defmodule SiteReport.Reports.DailyReport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daily_reports" do
    field :date, :date
    field :site_name, :string
    field :weather_conditions, :string
    field :workers_on_site, :integer
    field :work_completed, :string
    field :issues_encountered, :string
    field :materials_used, :string

    timestamps(type: :utc_datetime)
  end

  @required_fields [
    :date,
    :site_name,
    :weather_conditions,
    :workers_on_site,
    :work_completed
  ]
  @optional_fields [:issues_encountered, :materials_used]

  def changeset(daily_report, attrs) do
    daily_report
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:workers_on_site, greater_than_or_equal_to: 0)
  end
end
