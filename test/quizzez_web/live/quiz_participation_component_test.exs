defmodule QuizzezWeb.QuizParticipationComponentTest do
  use QuizzezWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias QuizzezWeb.QuizParticipationComponent

  describe "render" do
    test "renders quiz details", %{conn: conn} do
      question_1 = insert(:question, text: "This is the first question")
      question_2 = insert(:question, text: "This is the second question")
      question_3 = insert(:question, text: "This is the third question")

      quiz =
        insert(
          :quiz,
          title: "A simple quiz",
          description: "A quiz description",
          user: build(:user),
          questions: [question_1, question_2, question_3]
        )

      {:ok, _live, html} =
        live_isolated(conn, QuizParticipationComponent, session: %{"quiz" => quiz})

      assert html =~ "A simple quiz"
      assert html =~ "A quiz description"
      assert html =~ "3 questions"
    end
  end
end
