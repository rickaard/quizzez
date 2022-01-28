defmodule QuizzezWeb.QuizController do
  use QuizzezWeb, :controller

  alias Quizzez.Quizzes.Quiz
  alias QuizzezWeb.Authentication
  alias Quizzez.Quizzes

  plug(Guardian.Plug.EnsureAuthenticated when action in [:new, :edit])

  def new(conn, _params) do
    changeset = Quiz.changeset(%Quiz{}, %{})
    user = Authentication.get_current_user(conn)

    render(conn, "new.html", changeset: changeset, user: user)
  end

  def edit(conn, %{"id" => quiz_id} = params) do
    IO.inspect(params, label: "params")
    quiz_changeset = Quizzes.get_quiz!(quiz_id) |> IO.inspect() |> Quizzes.change_quiz()
    user = Authentication.get_current_user(conn)

    render(conn, "new.html", changeset: quiz_changeset, user: user)
  end
end
