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

  def handle_event("remove_question", params, socket) do
    %{"question-id" => "quiz_questions_" <> index} = params

    IO.puts("")
    IO.puts("Reming question with index: #{index}")
    IO.puts("")

    {:noreply, socket}
  end

  def handle_event("remove_answer", %{"answer-id" => answer_params} = _parmas, socket) do
    [_, _, question_index, _, answer_index] = String.split(answer_params, "_")

    IO.puts("")
    IO.puts("Removing answer with index: #{answer_index}")
    IO.puts("From question with index: #{question_index}")
    IO.puts("")

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

  defp question_number(question) do
    "quiz_questions_" <> index = question.id

    {number, _} = Integer.parse(index)

    Integer.to_string(number + 1)
  end
end
