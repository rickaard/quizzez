defmodule QuizzezWeb.PageController do
  use QuizzezWeb, :controller

  alias Quizzez.Quizzes
  alias Quizzez.Quizzes.Quiz

  plug(QuizzezWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete])

  def index(conn, _params) do
    all_quizzes = Quizzes.list_quizzes_with_questions()

    render(conn, "index.html", quizzes: all_quizzes)
  end
end
