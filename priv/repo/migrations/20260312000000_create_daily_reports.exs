defmodule SiteReport.Repo.Migrations.CreateDailyReports do
  use Ecto.Migration

  def change do
    create table(:daily_reports) do
      add :site_name, :string, null: false
      add :date, :date, null: false
      add :weather, :string, null: false
      add :notes, :text, null: false
      add :workers_on_site, :integer, null: false
      add :progress_summary, :text, null: false

      timestamps()
    end
  end
end
