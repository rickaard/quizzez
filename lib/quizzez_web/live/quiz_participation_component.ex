defmodule QuizzezWeb.QuizParticipationComponent do
  @moduledoc false
  import QuizzezWeb.ErrorHelpers

  use QuizzezWeb, :live_view
  use Phoenix.HTML

  def mount(_params, %{"quiz" => quiz} = _session, socket) do
    socket =
      socket
      |> assign(:quiz, quiz)
      |> assign(:current_question, 0)

    {:ok, socket}
  end

  def handle_event("next_question", _params, socket) do
    {:noreply, socket}
  end

  defp question_amount_text(questions) when length(questions) == 1, do: "1 question"
  defp question_amount_text(questions), do: "#{length(questions)} questions"
end
