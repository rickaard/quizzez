defmodule QuizzezWeb.CategoryControllerTest do
  use QuizzezWeb.ConnCase

  describe "GET /" do
    test "renders categories", %{conn: conn} do
      conn = get(conn, Routes.controller_path(conn, :index))

      response = html_response(conn, 200)
      assert response =~ "Food"
      assert response =~ "Geography"
      assert response =~ "History"
      assert response =~ "Math"
      assert response =~ "Misc"
      assert response =~ "Music"
      assert response =~ "Programming"
      assert response =~ "Science"
      assert response =~ "Workout"
    end
  end
end
