defmodule QuizzezWeb.Quiz.ParticipationViewTest do
  @moduledoc false
  use QuizzezWeb.ConnCase, async: true

  alias QuizzezWeb.Quiz.ParticipationView

  describe "question_amount_text/1" do
    test "handles more than 1 questions" do
      questions = ["question", "question", "question"]
      assert "3 questions" == ParticipationView.question_amount_text(questions)
    end

    test "handles 1 question" do
      questions = ["question"]
      assert "1 question" == ParticipationView.question_amount_text(questions)
    end

    test "handles 0 questions" do
      questions = []
      assert "0 questions" == ParticipationView.question_amount_text(questions)
    end
  end
end
