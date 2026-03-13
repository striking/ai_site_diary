defmodule SiteReportWeb.HealthControllerTest do
  use SiteReportWeb.ConnCase, async: true

  test "GET /health returns ok status", %{conn: conn} do
    conn = get(conn, ~p"/health")

    assert json_response(conn, 200) == %{"status" => "ok"}
  end
end
