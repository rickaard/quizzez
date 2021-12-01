defmodule QuizzezWeb.PageController do
  use QuizzezWeb, :controller

  alias Quizzez.Quizzes

  alias Quizzez.Quizzes.Quiz

  def index(conn, _params) do
    all_quizzes = Quizzes.list_quizzes_with_questions()
    IO.inspect(all_quizzes, label: "quizzes")

    render(conn, "index.html", quizzes: all_quizzes)
  end

  def new(conn, _params) do
    changeset = Quiz.changeset(%Quiz{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, params) do
    changeset = Quiz.changeset(%Quiz{}, %{})

    render(conn, "new.html", changeset: changeset)
  end
end
