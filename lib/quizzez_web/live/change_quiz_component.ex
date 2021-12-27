defmodule QuizzezWeb.ChangeQuizComponent do
  import QuizzezWeb.ErrorHelpers

  # use Phoenix.LiveComponent
  use QuizzezWeb, :live_view
  use Phoenix.HTML

  alias Quizzez.Repo
  alias Quizzez.Accounts.User
  alias Quizzez.Quizzes.Quiz
  alias Quizzez.Quizzes.Question
  alias Quizzez.Quizzes.Answer
  alias Quizzez.Quizzes

  def mount(_params, %{"user_id" => user_id} = _session, socket) do
    quiz = empty_full_quiz()

    changeset =
      Quizzes.change_quiz(quiz)
      |> Ecto.Changeset.put_assoc(:questions, quiz.questions)

    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:user_id, user_id)

    {:ok, socket}
  end

  def handle_event("validate", %{"quiz" => quiz_params} = _params, socket) do
    changeset =
      %Quiz{}
      |> Quizzes.change_quiz(quiz_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"quiz" => quiz} = _params, socket) do
    user = %User{} = Repo.get(User, socket.assigns.user_id)

    changeset =
      user
      |> Ecto.build_assoc(:quizzes)
      |> Quiz.changeset(quiz)

    case Repo.insert(changeset) do
      {:ok, %Quiz{}} ->
        socket =
          socket
          |> assign(:changeset, empty_full_quiz())
          |> put_flash(:info, "Quiz saved 👍")
          |> redirect(to: Routes.page_path(socket, :index))

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("add_question", _params, socket) do
    quiz_changeset = socket.assigns.changeset

    updated_questions =
      quiz_changeset
      |> Ecto.Changeset.get_field(:questions)
      |> Enum.concat([%Question{answers: [%Answer{}, %Answer{}]}])

    changeset =
      quiz_changeset
      |> Ecto.Changeset.put_assoc(:questions, updated_questions)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("add_answer", %{"question-id" => "quiz_questions_" <> index} = _params, socket) do
    quiz_changeset = socket.assigns.changeset
    {question_index, _} = Integer.parse(index)

    all_questions =
      quiz_changeset
      |> Ecto.Changeset.get_field(:questions)

    {_prev, updated_question} =
      all_questions
      |> Enum.fetch!(question_index)
      |> Map.get_and_update(:answers, fn answers_list ->
        {answers_list, answers_list ++ [%Answer{}]}
      end)

    updated_questions =
      all_questions
      |> List.replace_at(question_index, updated_question)

    changeset =
      quiz_changeset
      |> Ecto.Changeset.put_assoc(:questions, updated_questions)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("remove_question", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("remove_answer", _params, socket) do
    {:noreply, socket}
  end

  defp empty_full_quiz do
    %Quiz{
      questions: [
        %Question{
          answers: [
            %Answer{},
            %Answer{},
            %Answer{},
            %Answer{}
          ]
        }
      ]
    }
  end

  # defp transform_to_map(%{__struct__: _} = struct), do: Map.from_struct(struct)
  # defp transform_to_map(map) when is_map(map), do: map
  # defp transform_to_map(other), do: other
  # defp get_temp_id, do: :crypto.strong_rand_bytes(5) |> Base.url_encode64() |> binary_part(0, 5)
end
