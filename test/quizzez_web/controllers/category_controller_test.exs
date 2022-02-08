defmodule QuizzezWeb.CategoryControllerTest do
  use QuizzezWeb.ConnCase

  describe "GET /" do
    test "renders categories", %{conn: conn} do
      conn = get(conn, Routes.category_path(conn, :index))

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
      assert response =~ "No quizzes created for this category yet"
      refute response =~ "misc"
    end
  end
end
