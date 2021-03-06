defmodule QuizzezWeb.ChangeQuizComponent do
  @moduledoc false
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

  alias QuizzezWeb.SVGHelpers

  def mount(_params, %{"user" => user} = _session, socket) do
    quiz_changeset = empty_full_quiz()

    socket =
      socket
      |> assign(:changeset, quiz_changeset)
      |> assign(:user_id, user.id)
      |> assign(:selected_category, nil)

    {:ok, socket}
  end

  def handle_event("validate", %{"quiz" => %{"category" => category} = quiz_params}, socket) do
    changeset =
      %Quiz{}
      |> Quizzes.change_quiz(quiz_params)
      |> Map.put(:action, :validate)

    socket =
      socket
      |> assign(changeset: changeset)
      |> assign(selected_category: category)

    {:noreply, socket}
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
    {question_index, _} = Integer.parse(index)

    quiz_changeset = socket.assigns.changeset

    updated_questions =
      quiz_changeset
      |> Ecto.Changeset.get_field(:questions)
      |> List.delete_at(question_index)

    changeset =
      quiz_changeset
      |> Ecto.Changeset.put_assoc(:questions, updated_questions)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("remove_answer", %{"answer-id" => answer_params} = _parmas, socket) do
    quiz_changeset = socket.assigns.changeset
    [_, _, question_index, _, answer_index] = String.split(answer_params, "_")
    {question_index, _} = Integer.parse(question_index)
    {answer_index, _} = Integer.parse(answer_index)

    all_questions = Ecto.Changeset.get_field(quiz_changeset, :questions)

    {_prev, updated_question} =
      all_questions
      |> Enum.at(question_index)
      |> Map.get_and_update(:answers, fn answers_list ->
        {answers_list, List.delete_at(answers_list, answer_index)}
      end)

    updated_questions = List.replace_at(all_questions, question_index, updated_question)

    changeset = Ecto.Changeset.put_assoc(quiz_changeset, :questions, updated_questions)

    {:noreply, assign(socket, changeset: changeset)}
  end

  defp empty_full_quiz do
    quiz = %Quiz{}
    quiz_changeset = Quizzes.change_quiz(quiz)

    questions = [
      %Question{
        answers: [
          %Answer{},
          %Answer{}
        ]
      }
    ]

    Ecto.Changeset.put_assoc(quiz_changeset, :questions, questions)
  end

  defp question_number(question) do
    "quiz_questions_" <> index = question.id

    {number, _} = Integer.parse(index)

    Integer.to_string(number + 1)
  end

  defp question_amount(%{changeset: changeset} = _assigns) do
    changeset
    |> Ecto.Changeset.get_field(:questions)
    |> Enum.count()
  end

  defp answers_amount(%{changeset: changeset} = _assigns, question_index) do
    "quiz_questions_" <> index = question_index
    {question_index, _} = Integer.parse(index)

    changeset
    |> Ecto.Changeset.get_field(:questions)
    |> Enum.at(question_index)
    |> Map.get(:answers)
    |> Enum.count()
  end
end
