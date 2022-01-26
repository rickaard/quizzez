defmodule QuizzezWeb.QuizController do
  use QuizzezWeb, :controller

  alias Quizzez.Quizzes
  alias Quizzez.Quizzes.Quiz
  alias QuizzezWeb.Authentication

  plug(Guardian.Plug.EnsureAuthenticated when action in [:new, :create, :edit, :update, :delete])

  def index(conn, _params) do
    all_quizzes = Quizzes.list_quizzes_with_questions()

    render(conn, "index.html", quizzes: all_quizzes)
  end

  def show(conn, _params) do
    all_quizzes = Quizzes.list_quizzes_with_questions()

    render(conn, "show.html", quizzes: all_quizzes)
  end

  def new(conn, _params) do
    changeset = Quiz.changeset(%Quiz{}, %{})
    user = Authentication.get_current_user(conn)

    render(conn, "new.html", changeset: changeset, user: user)
  end
end
