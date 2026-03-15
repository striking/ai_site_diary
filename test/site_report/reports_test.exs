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

    test "create_daily_report/1 extracts report fields from a description" do
      description =
        "Installed steel beams in the north wing and completed the safety walkthrough. Two follow-up items remain for tomorrow."

      assert {:ok, %DailyReport{} = report} =
               Reports.create_daily_report(%{"description" => description})

      assert report.title ==
               "Installed steel beams in the north wing and completed the safety walkthrough"

      assert report.summary == description
      assert report.date == Date.utc_today()
    end

    test "extract_report_attrs/1 derives title, summary, and date" do
      description =
        "Completed the concrete pour for section B. Site cleanup finished before handover."

      assert %{title: title, summary: ^description, date: date} =
               Reports.extract_report_attrs(description)

      assert title == "Completed the concrete pour for section B"
      assert date == Date.utc_today()
    end

    test "list_daily_reports/0 returns all reports" do
      assert {:ok, %DailyReport{} = report} = Reports.create_daily_report(@valid_attrs)

      assert Reports.list_daily_reports() == [report]
    end

    test "get_daily_report!/1 returns the report by id" do
      assert {:ok, %DailyReport{} = report} = Reports.create_daily_report(@valid_attrs)

      assert Reports.get_daily_report!(report.id).id == report.id
    end

    test "delete_daily_report/1 deletes the report" do
      assert {:ok, %DailyReport{} = report} = Reports.create_daily_report(@valid_attrs)

      assert {:ok, %DailyReport{}} = Reports.delete_daily_report(report)
      assert_raise Ecto.NoResultsError, fn -> Reports.get_daily_report!(report.id) end
    end
  end
end
