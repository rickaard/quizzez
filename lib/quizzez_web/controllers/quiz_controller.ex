defmodule QuizzezWeb.QuizController do
  use QuizzezWeb, :controller

  alias Quizzez.Quizzes
  alias Quizzez.Quizzes.Quiz

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

    render(conn, "new.html", changeset: changeset)
  end
end
