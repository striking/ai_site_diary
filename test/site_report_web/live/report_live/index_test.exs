defmodule SiteReportWeb.ReportLive.IndexTest do
  use SiteReportWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias SiteReport.Reports

  @valid_attrs %{
    site_name: "North Tower Redevelopment",
    date: ~D[2026-03-10],
    weather: "Sunny",
    notes: "Materials delivered on schedule.",
    workers_on_site: 18,
    progress_summary: "Concrete pour completed for level 2."
  }

  describe "delete confirmation modal" do
    test "opens and closes the modal without deleting the report", %{conn: conn} do
      {:ok, daily_report} = Reports.create_daily_report(@valid_attrs)
      {:ok, view, _html} = live(conn, ~p"/reports")

      assert has_element?(view, "#report-#{daily_report.id}")
      refute has_element?(view, "#delete-report-modal")

      view
      |> element("#delete-report-button-#{daily_report.id}")
      |> render_click()

      assert has_element?(view, "#delete-report-modal")
      assert render(view) =~ "Are you sure you want to delete the report for"
      assert render(view) =~ "#{daily_report.date} — #{daily_report.site_name}"

      view
      |> element("#cancel-delete-button")
      |> render_click()

      refute has_element?(view, "#delete-report-modal")
      assert has_element?(view, "#report-#{daily_report.id}")
      assert Reports.get_daily_report!(daily_report.id).id == daily_report.id
    end

    test "deletes the report after confirmation", %{conn: conn} do
      {:ok, daily_report} = Reports.create_daily_report(@valid_attrs)
      {:ok, view, _html} = live(conn, ~p"/reports")

      view
      |> element("#delete-report-button-#{daily_report.id}")
      |> render_click()

      assert has_element?(view, "#delete-report-modal")

      view
      |> element("#confirm-delete-button")
      |> render_click()

      refute has_element?(view, "#delete-report-modal")
      refute has_element?(view, "#report-#{daily_report.id}")
      assert render(view) =~ "Daily report deleted successfully."
      assert_raise Ecto.NoResultsError, fn -> Reports.get_daily_report!(daily_report.id) end
    end
  end
end
