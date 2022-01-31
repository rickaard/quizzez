defmodule QuizzezWeb.QuizParticipationComponent do
  @moduledoc false
  import QuizzezWeb.ErrorHelpers

  use QuizzezWeb, :live_view
  use Phoenix.HTML

  def mount(_params, %{"quiz" => quiz} = _session, socket) do
    socket =
      socket
      |> assign(:quiz, quiz)
      |> assign(:current_question, nil)
      |> assign(:current_question_index, nil)
      |> assign(:status, :unstarted)
      |> assign(:questions_amount, length(quiz.questions))

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

    {:noreply, assign(socket, :current_question, next_question)}
  end

  def handle_event("calculate-score", _params, socket) do
    {:noreply, socket}
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

    {:noreply, assign(socket, :current_question, next_question)}
  end

  defp question_amount_text(questions) when length(questions) == 1, do: "1 question"
  defp question_amount_text(questions), do: "#{length(questions)} questions"

  def last_question?(%{current_question_index: current, questions_amount: questions} = _assigns) do
    current + 1 == questions
  end

  def first_question?(%{current_question_index: current} = _assigns) do
    current == 0
  end
end
