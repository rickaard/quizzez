defmodule QuizzezWeb.QuizParticipationComponent do
  @moduledoc false
  import QuizzezWeb.ErrorHelpers

  use QuizzezWeb, :live_view
  use Phoenix.HTML

  alias Quizzez.Quizzes.Question
  alias Quizzez.Quizzes.Answer

  def mount(_params, %{"quiz" => quiz} = _session, socket) do
    socket =
      socket
      |> assign(:quiz, quiz)
      |> assign(:current_question, nil)
      |> assign(:current_question_index, nil)
      |> assign(:status, :unstarted)
      |> assign(:questions_amount, length(quiz.questions))
      |> assign(:answers, [])

    {:ok, socket}
  end

  def handle_event("start-quiz", _params, socket) do
    all_questions = socket.assigns.quiz.questions
    first_question = List.first(all_questions)

    socket =
      socket
      |> assign(:current_question, first_question)
      |> assign(:current_question_index, 0)
      |> assign(:status, :started)

    {:noreply, socket}
  end

  def handle_event("prev-question", _params, socket) do
    all_questions = socket.assigns.quiz.questions
    prev_question_index = socket.assigns.current_question_index

    next_question =
      Enum.at(
        all_questions,
        prev_question_index - 1,
        socket.assigns.current_question
      )

    socket =
      socket
      |> assign(:current_question, next_question)
      |> assign(:current_question_index, prev_question_index - 1)
      |> assign(:current_question, next_question)

    {:noreply, socket}
  end

  def handle_event("calculate-score", _params, socket) do
    IO.inspect(socket.assigns.answers, label: "answers")
    {:noreply, socket}
  end

  # def handle_event("answer-question", params, socket) do
  #   IO.inspect(params, label: "params")
  #   {:noreply, socket}
  # end

  def handle_event("answer-question", %{"answer-id" => answer_id} = _params, socket) do
    current_question = socket.assigns.current_question

    answers =
      Enum.reject(socket.assigns.answers, fn answer ->
        answer.question_id == current_question.id
      end)

    chosen_answer = Enum.find(current_question.answers, fn answer -> answer.id == answer_id end)

    answer_for_question = %{question_id: current_question.id, answer_id: chosen_answer.id}

    {:noreply, assign(socket, :answers, answers ++ [answer_for_question])}
  end

  def handle_event("next-question", _params, socket) do
    all_questions = socket.assigns.quiz.questions
    prev_question_index = socket.assigns.current_question_index

    next_question =
      Enum.at(
        all_questions,
        prev_question_index + 1,
        socket.assigns.current_question
      )

    socket =
      socket
      |> assign(:current_question, next_question)
      |> assign(:current_question_index, prev_question_index + 1)
      |> assign(:current_question, next_question)

    {:noreply, socket}
  end

  defp question_amount_text(questions) when length(questions) == 1, do: "1 question"
  defp question_amount_text(questions), do: "#{length(questions)} questions"

  def last_question?(%{current_question_index: current, questions_amount: questions} = _assigns) do
    current + 1 == questions
  end

  def first_question?(%{current_question_index: current} = _assigns) do
    current == 0
  end

  def selected_answer_for_question?(%Answer{id: answer_id}, %{answers: answers} = assigns) do
    case question_answered?(assigns) do
      true ->
        selected_answer_for_question =
          Enum.find(answers, fn answer -> answer.question_id == assigns.current_question.id end)

        answer_id == selected_answer_for_question.answer_id

      false ->
        false
    end
  end

  defp question_answered?(%{answers: answers, current_question: current_question} = _assigns) do
    Enum.any?(answers, fn answer -> answer.question_id == current_question.id end)
  end

  defp answer_button_classes(answer, assigns) do
    case selected_answer_for_question?(answer, assigns) do
      true ->
        "border border-solid border-gray-400 py-2 px-4 w-full bg-primary text-white"

      false ->
        "border border-solid border-gray-400 py-2 px-4 w-full hover:bg-primary-50 hover:text-white"
    end
  end
end
