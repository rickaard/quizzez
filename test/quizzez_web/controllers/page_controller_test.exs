defmodule QuizzezWeb.PageControllerTest do
  use QuizzezWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "QUIZZ"
  end
end
