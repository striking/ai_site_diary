defmodule SiteReportWeb.ReportLive.NewTest do
  use SiteReportWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders form with report fields and back link", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/reports/new")

    assert html =~ "report-form"
    assert html =~ "name=\"report[title]\""
    assert html =~ "name=\"report[summary]\""
    assert html =~ "name=\"report[date]\""
    assert html =~ "Back to reports"
    assert html =~ ~p"/reports"
  end

  test "validation errors re-render the form", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/reports/new")

    html =
      view
      |> form("#report-form", report: %{title: "", summary: "Done work", date: "2026-03-13"})
      |> render_change()

    assert html =~ "can&#39;t be blank"
    assert html =~ "name=\"report[title]\""
  end

  test "successful submission redirects to reports", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/reports/new")

    valid_attrs = %{
      title: "Daily update",
      summary: "Completed site walkthrough.",
      date: "2026-03-13"
    }

    assert {:error, {:live_redirect, %{to: "/reports"}}} =
             view |> form("#report-form", report: valid_attrs) |> render_submit()
  end
end
