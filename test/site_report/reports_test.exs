defmodule SiteReport.ReportsTest do
  use SiteReport.DataCase, async: true

  alias SiteReport.Reports
  alias SiteReport.Reports.DailyReport

  @valid_attrs %{
    site_name: "North Tower Redevelopment",
    date: ~D[2026-03-10],
    weather: "Sunny",
    notes: "Materials delivered on schedule.",
    workers_on_site: 18,
    progress_summary: "Concrete pour completed for level 2."
  }

  @update_attrs %{
    site_name: "North Tower Redevelopment - Phase 2",
    date: ~D[2026-03-11],
    weather: "Cloudy",
    notes: "Minor delays due to a crane inspection.",
    workers_on_site: 21,
    progress_summary: "Rebar installation progressed across the western wing."
  }

  @invalid_attrs %{
    site_name: nil,
    date: nil,
    weather: nil,
    notes: nil,
    workers_on_site: nil,
    progress_summary: nil
  }

  describe "daily reports" do
    test "create_daily_report/1 with valid data creates a daily report" do
      assert {:ok, %DailyReport{} = daily_report} = Reports.create_daily_report(@valid_attrs)
      assert daily_report.site_name == "North Tower Redevelopment"
      assert daily_report.date == ~D[2026-03-10]
      assert daily_report.weather == "Sunny"
      assert daily_report.notes == "Materials delivered on schedule."
      assert daily_report.workers_on_site == 18
      assert daily_report.progress_summary == "Concrete pour completed for level 2."
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
             } = errors_on(changeset)
    end

    test "get_daily_report!/1 returns the daily report with the given id" do
      assert {:ok, %DailyReport{} = daily_report} = Reports.create_daily_report(@valid_attrs)

      assert Reports.get_daily_report!(daily_report.id).id == daily_report.id
    end

    test "list_daily_reports/0 returns all daily reports" do
      assert {:ok, %DailyReport{} = daily_report} = Reports.create_daily_report(@valid_attrs)

      assert Reports.list_daily_reports() == [daily_report]
    end

    test "update_daily_report/2 with valid data updates the daily report" do
      assert {:ok, %DailyReport{} = daily_report} = Reports.create_daily_report(@valid_attrs)

      assert {:ok, %DailyReport{} = updated_report} =
               Reports.update_daily_report(daily_report, @update_attrs)

      assert updated_report.site_name == "North Tower Redevelopment - Phase 2"
      assert updated_report.date == ~D[2026-03-11]
      assert updated_report.weather == "Cloudy"
      assert updated_report.notes == "Minor delays due to a crane inspection."
      assert updated_report.workers_on_site == 21

      assert updated_report.progress_summary ==
               "Rebar installation progressed across the western wing."
    end

    test "update_daily_report/2 with invalid data returns an error changeset" do
      assert {:ok, %DailyReport{} = daily_report} = Reports.create_daily_report(@valid_attrs)

      assert {:error, changeset} =
               Reports.update_daily_report(daily_report, %{workers_on_site: -1})

      assert %{workers_on_site: ["must be greater than or equal to 0"]} = errors_on(changeset)

      assert Reports.get_daily_report!(daily_report.id).workers_on_site == 18
    end

    test "delete_daily_report/1 deletes the daily report" do
      assert {:ok, %DailyReport{} = daily_report} = Reports.create_daily_report(@valid_attrs)

      assert {:ok, %DailyReport{} = deleted_report} = Reports.delete_daily_report(daily_report)
      assert deleted_report.id == daily_report.id
      assert Reports.list_daily_reports() == []
    end
  end
end
