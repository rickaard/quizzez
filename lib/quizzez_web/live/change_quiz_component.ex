defmodule QuizzezWeb.ChangeQuizComponent do
  import QuizzezWeb.ErrorHelpers

  # use Phoenix.LiveComponent
  use QuizzezWeb, :live_view
  use Phoenix.HTML

  # alias Quizzez.Repo
  alias Quizzez.Quizzes.Quiz
  alias Quizzez.Quizzes

  def mount(_params, _session, socket) do
    changeset = Quizzes.change_quiz(%Quiz{})
    IO.inspect(changeset, label: "mount changeset")

    {:ok, assign(socket, %{changeset: changeset})}
  end

  def handle_event("validate", %{"quiz" => quiz_params}, socket) do
    IO.inspect(quiz_params, label: "params")

    changeset =
      %Quiz{}
      |> Quizzes.change_quiz(quiz_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", _params, socket) do
    {:noreply, assign(socket, changeset: Quizzes.change_quiz(%Quiz{}))}
  end
end
