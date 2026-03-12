defmodule SiteReport.ReportsTest do
  use SiteReport.DataCase, async: true

  alias SiteReport.Reports
  alias SiteReport.Reports.DailyReport

  describe "daily_reports" do
    @valid_attrs %{
      site_name: "Tower Block A",
      date: ~D[2026-03-12],
      weather: "Sunny",
      notes: "Concrete pour completed and site left tidy.",
      workers_on_site: 18,
      progress_summary: "Finished level 2 slab reinforcement and inspections."
    }

    @update_attrs %{
      weather: "Cloudy",
      notes: "Afternoon showers delayed exterior works.",
      workers_on_site: 14,
      progress_summary: "Interior framing advanced in zone 3."
    }

    @invalid_attrs %{
      site_name: nil,
      date: nil,
      weather: nil,
      notes: nil,
      workers_on_site: nil,
      progress_summary: nil
    }

    test "create_daily_report/1 with valid data creates a daily report" do
      assert {:ok, %DailyReport{} = daily_report} = Reports.create_daily_report(@valid_attrs)
      assert daily_report.site_name == "Tower Block A"
      assert daily_report.date == ~D[2026-03-12]
      assert daily_report.weather == "Sunny"
      assert daily_report.notes == "Concrete pour completed and site left tidy."
      assert daily_report.workers_on_site == 18

      assert daily_report.progress_summary ==
               "Finished level 2 slab reinforcement and inspections."
    end

    test "create_daily_report/1 with invalid data returns an error changeset" do
      assert {:error, changeset} = Reports.create_daily_report(@invalid_attrs)

      assert %{
               site_name: ["can't be blank"],
               date: ["can't be blank"],
               weather: ["can't be blank"],
               notes: ["can't be blank"],
               workers_on_site: ["can't be blank"],
               progress_summary: ["can't be blank"]
             } =
               errors_on(changeset)
    end

    test "get_daily_report!/1 returns the daily report with given id" do
      assert {:ok, daily_report} = Reports.create_daily_report(@valid_attrs)

      fetched_report = Reports.get_daily_report!(daily_report.id)

      assert fetched_report.id == daily_report.id
      assert fetched_report.site_name == daily_report.site_name
    end

    test "list_daily_reports/0 returns all daily reports" do
      assert {:ok, older_report} =
               Reports.create_daily_report(%{
                 @valid_attrs
                 | site_name: "Tower Block B",
                   date: ~D[2026-03-10]
               })

      assert {:ok, newer_report} =
               Reports.create_daily_report(%{
                 @valid_attrs
                 | site_name: "Tower Block C",
                   date: ~D[2026-03-12]
               })

      assert Reports.list_daily_reports() == [newer_report, older_report]
    end

    test "update_daily_report/2 updates the daily report" do
      assert {:ok, daily_report} = Reports.create_daily_report(@valid_attrs)

      assert {:ok, %DailyReport{} = updated_report} =
               Reports.update_daily_report(daily_report, @update_attrs)

      assert updated_report.weather == "Cloudy"
      assert updated_report.notes == "Afternoon showers delayed exterior works."
      assert updated_report.workers_on_site == 14
      assert updated_report.progress_summary == "Interior framing advanced in zone 3."
    end

    test "update_daily_report/2 with invalid data returns an error changeset" do
      assert {:ok, daily_report} = Reports.create_daily_report(@valid_attrs)

      assert {:error, changeset} =
               Reports.update_daily_report(daily_report, %{workers_on_site: -1})

      assert %{workers_on_site: ["must be greater than or equal to 0"]} = errors_on(changeset)

      reloaded_report = Reports.get_daily_report!(daily_report.id)
      assert reloaded_report.workers_on_site == 18
    end
  end
end
