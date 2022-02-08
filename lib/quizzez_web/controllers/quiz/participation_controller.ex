defmodule QuizzezWeb.Quiz.ParticipationController do
  use QuizzezWeb, :controller

  alias Quizzez.Quizzes
  alias Quizzez.Quizzes.Quiz

  plug :put_layout, {QuizzezWeb.LayoutView, "quiz_participation.html"}

  def show(conn, %{"quiz_id" => quiz_id} = _params) do
    case Quizzes.get_quiz_with_questions_and_answers(quiz_id) do
      quiz = %Quiz{} ->
        conn
        |> render("show.html", quiz: quiz)

      nil ->
        conn
        |> put_flash(:error, "No quiz with that ID found")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end
