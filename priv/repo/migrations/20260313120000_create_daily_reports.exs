defmodule SiteReport.Repo.Migrations.CreateDailyReports do
  use Ecto.Migration

  def change do
    create table(:daily_reports) do
      add :title, :string, null: false
      add :summary, :text, null: false
      add :date, :date, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
