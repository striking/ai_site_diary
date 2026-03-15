defmodule SiteReportWeb.PageControllerTest do
  use SiteReportWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    html = html_response(conn, 200)

    assert html =~ "Site Report AI"
    assert html =~ "Turn a quick description of the day's site activity into a structured daily report"
  end
end
