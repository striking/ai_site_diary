defmodule SiteReportWeb.ReportLive.IndexTest do
  use SiteReportWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders empty state when there are no daily reports", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/reports")

    assert html =~ "No daily reports yet"
    assert html =~ "Create a new report"
  end
end
