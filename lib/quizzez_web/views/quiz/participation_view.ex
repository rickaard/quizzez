defmodule QuizzezWeb.Quiz.ParticipationView do
  use QuizzezWeb, :view

  def question_amount_text(questions) when length(questions) == 1 do
    "1 question"
  end

  def question_amount_text(questions) do
    "#{length(questions)} questions"
  end
end
