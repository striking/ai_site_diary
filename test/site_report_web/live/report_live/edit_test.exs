defmodule SiteReportWeb.ReportLive.EditTest do
  use SiteReportWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias SiteReport.Reports

  describe "edit daily report" do
    setup do
      {:ok, report} =
        Reports.create_daily_report(%{
          title: "Original title",
          summary: "Original summary",
          date: ~D[2026-03-13]
        })

      %{report: report}
    end

    test "renders pre-filled form with back link", %{conn: conn, report: report} do
      {:ok, _view, html} = live(conn, ~p"/reports/#{report.id}/edit")

      assert html =~ "Edit daily report"
      assert html =~ "value=\"Original title\""
      assert html =~ "Original summary"
      assert html =~ "value=\"2026-03-13\""
      assert html =~ "Back to reports"
      assert html =~ ~p"/reports"
    end

    test "validation errors re-render the form", %{conn: conn, report: report} do
      {:ok, view, _html} = live(conn, ~p"/reports/#{report.id}/edit")

      html =
        view
        |> form("#report-form",
          report: %{title: "", summary: "Updated summary", date: "2026-03-14"}
        )
        |> render_submit()

      assert html =~ "can&#39;t be blank"
      assert html =~ "name=\"report[title]\""
    end

    test "successful submission redirects to reports", %{conn: conn, report: report} do
      {:ok, view, _html} = live(conn, ~p"/reports/#{report.id}/edit")

      valid_attrs = %{
        title: "Updated title",
        summary: "Updated summary",
        date: "2026-03-14"
      }

      assert {:error, {:live_redirect, %{to: "/reports"}}} =
               view |> form("#report-form", report: valid_attrs) |> render_submit()
    end

    test "visiting a non-existent id raises", %{conn: conn} do
      assert_raise Ecto.NoResultsError, fn ->
        live(conn, ~p"/reports/0/edit")
      end
    end
  end
end
