defmodule QuizzezWeb.QuizParticipationComponent do
  @moduledoc false
  import QuizzezWeb.ErrorHelpers

  use QuizzezWeb, :live_view
  use Phoenix.HTML

  def mount(_params, %{"quiz" => quiz} = _session, socket) do
    IO.inspect(quiz)

    socket =
      socket
      |> assign(:quiz, quiz)

    {:ok, socket}
  end

  def question_amount_text(questions) when length(questions) == 1, do: "1 question"
  def question_amount_text(questions), do: "#{length(questions)} questions"
end
