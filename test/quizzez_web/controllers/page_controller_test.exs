defmodule QuizzezWeb.PageControllerTest do
  use QuizzezWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "QUIZZ"
  end
end
