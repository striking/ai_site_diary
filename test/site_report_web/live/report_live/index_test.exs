defmodule SiteReportWeb.ReportLive.IndexTest do
  use SiteReportWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias SiteReport.Reports

  test "renders empty state when there are no daily reports", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/reports")

    assert html =~ "No daily reports yet"
    assert html =~ "Create a new report"
  end

  test "renders edit link for each report", %{conn: conn} do
    {:ok, report} =
      Reports.create_daily_report(%{
        title: "Daily update",
        summary: "Completed site walkthrough.",
        date: ~D[2026-03-13]
      })

    {:ok, _view, html} = live(conn, ~p"/reports")

    assert html =~ "Edit"
    assert html =~ ~p"/reports/#{report.id}/edit"
  end
end
