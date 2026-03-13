defmodule SiteReport.ReportsTest do
  use SiteReport.DataCase, async: true

  alias SiteReport.Reports
  alias SiteReport.Reports.DailyReport

  describe "daily_reports" do
    @valid_attrs %{
      title: "Foundation pour",
      summary: "Completed the concrete pour for section B.",
      date: ~D[2026-03-13]
    }

    test "create_daily_report/1 creates a report" do
      assert {:ok, %DailyReport{} = report} = Reports.create_daily_report(@valid_attrs)
      assert report.title == "Foundation pour"
      assert report.summary == "Completed the concrete pour for section B."
      assert report.date == ~D[2026-03-13]
    end

    test "list_daily_reports/0 returns all reports" do
      assert {:ok, %DailyReport{} = report} = Reports.create_daily_report(@valid_attrs)

      assert Reports.list_daily_reports() == [report]
    end

    test "get_daily_report!/1 returns the report by id" do
      assert {:ok, %DailyReport{} = report} = Reports.create_daily_report(@valid_attrs)

      assert Reports.get_daily_report!(report.id).id == report.id
    end

    test "update_daily_report/2 updates the report" do
      assert {:ok, %DailyReport{} = report} = Reports.create_daily_report(@valid_attrs)

      assert {:ok, %DailyReport{} = updated_report} =
               Reports.update_daily_report(report, %{
                 title: "Updated title",
                 summary: "Updated summary",
                 date: ~D[2026-03-14]
               })

      assert updated_report.title == "Updated title"
      assert updated_report.summary == "Updated summary"
      assert updated_report.date == ~D[2026-03-14]
    end

    test "delete_daily_report/1 deletes the report" do
      assert {:ok, %DailyReport{} = report} = Reports.create_daily_report(@valid_attrs)

      assert {:ok, %DailyReport{}} = Reports.delete_daily_report(report)
      assert_raise Ecto.NoResultsError, fn -> Reports.get_daily_report!(report.id) end
    end
  end
end
