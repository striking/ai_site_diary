defmodule SiteReport.ReportsTest do
  use SiteReport.DataCase, async: true

  alias SiteReport.Reports
  alias SiteReport.Reports.DailyReport

  describe "daily_reports" do
    test "create_daily_report/1 with valid data creates a daily report" do
      valid_attrs = %{
        date: ~D[2026-03-12],
        site_name: "North Tower",
        weather_conditions: "Sunny",
        workers_on_site: 12,
        work_completed: "Completed framing on level 2.",
        issues_encountered: "Delayed concrete delivery.",
        materials_used: "Concrete, rebar, timber"
      }

      assert {:ok, %DailyReport{} = daily_report} = Reports.create_daily_report(valid_attrs)
      assert daily_report.date == ~D[2026-03-12]
      assert daily_report.site_name == "North Tower"
      assert daily_report.weather_conditions == "Sunny"
      assert daily_report.workers_on_site == 12
      assert daily_report.work_completed == "Completed framing on level 2."
      assert daily_report.issues_encountered == "Delayed concrete delivery."
      assert daily_report.materials_used == "Concrete, rebar, timber"
    end

    test "create_daily_report/1 with invalid data returns an error changeset" do
      invalid_attrs = %{
        date: nil,
        site_name: nil,
        weather_conditions: nil,
        workers_on_site: -1,
        work_completed: nil
      }

      assert {:error, changeset} = Reports.create_daily_report(invalid_attrs)

      assert %{
               date: ["can't be blank"],
               site_name: ["can't be blank"],
               weather_conditions: ["can't be blank"],
               workers_on_site: ["must be greater than or equal to 0"],
               work_completed: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "list_daily_reports/0 returns reports ordered by newest date first" do
      {:ok, older_report} =
        Reports.create_daily_report(%{
          date: ~D[2026-03-10],
          site_name: "South Yard",
          weather_conditions: "Cloudy",
          workers_on_site: 8,
          work_completed: "Installed drainage lines."
        })

      {:ok, newer_report} =
        Reports.create_daily_report(%{
          date: ~D[2026-03-11],
          site_name: "North Tower",
          weather_conditions: "Clear",
          workers_on_site: 10,
          work_completed: "Poured foundation footing."
        })

      assert Reports.list_daily_reports() == [newer_report, older_report]
    end

    test "get_daily_report!/1 returns the daily report with the given id" do
      {:ok, daily_report} =
        Reports.create_daily_report(%{
          date: ~D[2026-03-12],
          site_name: "East Annex",
          weather_conditions: "Windy",
          workers_on_site: 6,
          work_completed: "Completed scaffold inspection."
        })

      assert Reports.get_daily_report!(daily_report.id).id == daily_report.id
    end
  end
end
