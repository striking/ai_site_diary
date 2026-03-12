defmodule SiteReport.Repo.Migrations.CreateDailyReports do
  use Ecto.Migration

  def change do
    create table(:daily_reports) do
      add :date, :date, null: false
      add :site_name, :string, null: false
      add :weather_conditions, :string, null: false
      add :workers_on_site, :integer, null: false
      add :work_completed, :text, null: false
      add :issues_encountered, :text
      add :materials_used, :text

      timestamps(type: :utc_datetime)
    end
  end
end
