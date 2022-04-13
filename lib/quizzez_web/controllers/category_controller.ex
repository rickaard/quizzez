defmodule QuizzezWeb.CategoryController do
  use QuizzezWeb, :controller

  alias Quizzez.Helpers
  alias Quizzez.Quizzes

  def index(conn, _params) do
    categories = ~w[food geography history math misc music programming science workout]

    conn
    |> Metatags.put("title", "Categories")
    |> Metatags.put("description", "Pick a category full of quizzes")
    |> render("index.html", categories: categories)
  end

  def show(conn, %{"category" => category} = _params) do
    quizzes = Quizzes.list_quizzez_with_questions_from_category(category)

    conn
    |> Metatags.put("title", "Quizzes about #{Helpers.upcase_first_letter(category)}")
    |> Metatags.put("description", "Pick a quiz from the #{category} category")
    |> render("show.html", quizzes: quizzes, category: category)
  end
end
