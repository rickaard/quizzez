defmodule QuizzezWeb.CategoryController do
  use QuizzezWeb, :controller

  alias Quizzez.Quizzes

  def index(conn, _params) do
    categories = ~w[food geography history math misc music programming science workout]

    render(conn, "index.html", categories: categories)
  end

  def show(conn, %{"category" => category} = _params) do
    quizzes = Quizzes.list_quizzez_with_questions_from_category(category)

    render(conn, "show.html", quizzes: quizzes, category: category)
  end
end
