defmodule QuizzezWeb.QuizController do
  use QuizzezWeb, :controller

  alias Quizzez.Quizzes.Quiz
  alias QuizzezWeb.Authentication
  alias Quizzez.Quizzes

  plug(Guardian.Plug.EnsureAuthenticated when action in [:new, :edit])

  def new(conn, _params) do
    changeset = Quiz.changeset(%Quiz{}, %{})
    user = Authentication.get_current_user(conn)

    conn
    |> Metatags.put("title", "Create new quiz")
    |> render("new.html", changeset: changeset, user: user)
  end

  def edit(conn, %{"id" => quiz_id} = _params) do
    quiz_changeset = Quizzes.get_quiz!(quiz_id) |> Quizzes.change_quiz()
    user = Authentication.get_current_user(conn)

    conn
    |> Metatags.put("title", "Edit quiz")
    |> render("new.html", changeset: quiz_changeset, user: user)
  end
end
