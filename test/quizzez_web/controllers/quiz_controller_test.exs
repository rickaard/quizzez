defmodule QuizzezWeb.QuizControllerTest do
  use QuizzezWeb.ConnCase, async: true

  describe "GET /" do
    test "renders `create new quiz` form for logged in user", %{conn: conn} do
      user = insert(:user)

      conn =
        conn
        |> log_in_user(user)
        |> get(Routes.quiz_path(conn, :new))

      response = html_response(conn, 200)
      assert response =~ "Quiz Info"
      assert response =~ "Save quiz"
    end

    test "does not allow non logged in users to visit `create new quiz page`", %{conn: conn} do
      conn = get(conn, Routes.quiz_path(conn, :new))

      assert redirected_to(conn, 302) == Routes.page_path(conn, :index)
    end
  end
end
