defmodule QuizzezWeb.CategoryController do
  use QuizzezWeb, :controller

  alias Quizzez.Quizzes

  def index(conn, _params) do
    all_quizzes = Quizzes.list_quizzes_with_questions()
    IO.inspect(all_quizzes)

    render(conn, "index.html", quizzes: all_quizzes)
  end
end
