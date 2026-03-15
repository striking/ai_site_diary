defmodule SiteReportWeb.ReportLive.NewTest do
  use SiteReportWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders simplified form with description field and back link", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/reports/new")

    assert html =~ "report-form"
    assert html =~ "name=\"report[description]\""
    refute html =~ "name=\"report[title]\""
    refute html =~ "name=\"report[summary]\""
    refute html =~ "name=\"report[date]\""
    assert html =~ "Back to reports"
    assert html =~ "Site Report AI"
  end

  test "validation errors re-render the form", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/reports/new")

    html =
      view
      |> form("#report-form", report: %{description: ""})
      |> render_change()

    assert html =~ "can&#39;t be blank"
    assert html =~ "name=\"report[description]\""
  end

  test "successful submission redirects to reports", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/reports/new")

    valid_attrs = %{
      description: "Installed steel beams in the north wing and completed the safety walkthrough."
    }

    assert {:error, {:live_redirect, %{to: "/reports"}}} =
             view |> form("#report-form", report: valid_attrs) |> render_submit()
  end
end
