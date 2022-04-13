defmodule QuizzezWeb.CategoryControllerTest do
  use QuizzezWeb.ConnCase, async: true

  describe "GET /" do
    test "renders categories", %{conn: conn} do
      conn = get(conn, Routes.category_path(conn, :index))

      response = html_response(conn, 200)
      assert response =~ "FOOD"
      assert response =~ "GEOGRAPHY"
      assert response =~ "HISTORY"
      assert response =~ "MATH"
      assert response =~ "MISC"
      assert response =~ "MUSIC"
      assert response =~ "PROGRAMMING"
      assert response =~ "SCIENCE"
      assert response =~ "WORKOUT"
    end
  end

  describe "SHOW /" do
    test "renders only quizzes for specific category", %{conn: conn} do
      user = insert(:user)
      insert(:quiz, user: user, category: "misc")
      insert(:quiz, user: user, category: "programming")

      conn = get(conn, Routes.category_path(conn, :show, "misc"))

      response = html_response(conn, 200)
      assert response =~ "misc"
      refute response =~ "programming"
    end

    test "renders `no quizzes created` text", %{conn: conn} do
      insert(:quiz, user: build(:user), category: "programming")

      conn = get(conn, Routes.category_path(conn, :show, "misc"))

      response = html_response(conn, 200)
      assert response =~ "Oh, no..."
      assert response =~ "No quizzes created for this category yet"
      refute response =~ "All quizzes for misc"
    end
  end
end
