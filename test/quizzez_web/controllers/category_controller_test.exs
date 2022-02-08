defmodule QuizzezWeb.CategoryControllerTest do
  use QuizzezWeb.ConnCase

  describe "GET /" do
    test "renders categories", %{conn: conn} do
      categories = ~w[food geography history math misc music programming science workout]

      Enum.each(categories, fn category ->
        insert(:quiz, category: category)
      end)

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
end
