defmodule QuizzezWeb.ProfileControllerTest do
  use QuizzezWeb.ConnCase

  describe "GET :show" do
    test "redirects to start page if user is not logged in", %{conn: conn} do
      conn = get(conn, Routes.profile_path(conn, :show, 1))
      assert redirected_to(conn, 302) == Routes.page_path(conn, :index)
    end

    test "redirects to own profile page when trying to visit someone elses profile", %{conn: conn} do
      user = insert(:user)
      user_2 = insert(:user)

      conn =
        conn
        |> log_in_user(user)
        |> get(Routes.profile_path(conn, :show, user_2.id))

      assert redirected_to(conn, 302) == Routes.profile_path(conn, :show, user.id)
    end

    test "shows profile page for user", %{conn: conn} do
      user = insert(:user, name: "John Doe")
      todays_date = Date.to_iso8601(Date.utc_today())

      conn =
        conn
        |> log_in_user(user)
        |> get(Routes.profile_path(conn, :show, user.id))

      response = html_response(conn, 200)
      assert response =~ "Hi John Doe, welcome to your profile"
      assert response =~ "Active since"
      assert response =~ todays_date
      assert response =~ "You have no created quizzes."
    end

    test "shows amount of quizzes created on profile page", %{conn: conn} do
      user = insert(:user)
      insert(:quiz, user: user, category: "misc")

      conn =
        conn
        |> log_in_user(user)
        |> get(Routes.profile_path(conn, :show, user.id))

      assert(
        html_response(conn, 200) =~
          "<p>You currently have <span class=\"font-bold\">1</span> created quiz."
      )
    end

    test "shows quiz details for created quizzes", %{conn: conn} do
      user = insert(:user)

      quiz =
        insert(
          :quiz,
          user: user,
          title: "Elixir quiz",
          description: "A small and simple quiz about Elixir",
          category: "programming"
        )

      insert(:question, quiz: quiz)

      conn =
        conn
        |> log_in_user(user)
        |> get(Routes.profile_path(conn, :show, user.id))

      response = html_response(conn, 200)
      assert response =~ "Elixir quiz"
      assert response =~ "A small and simple quiz about Elixir"
      assert response =~ "1 question"
      assert response =~ "programming"
    end
  end
end
