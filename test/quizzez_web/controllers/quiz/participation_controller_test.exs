defmodule QuizzezWeb.Survey.ParticipationControllerTest do
  use QuizzezWeb.ConnCase, async: true

  describe "GET /" do
    test "renders quiz details", %{conn: conn} do
      quiz =
        insert(
          :quiz,
          title: "A simple quiz",
          description: "A quiz description",
          user: build(:user)
        )

      insert(:question, quiz: quiz, text: "This is the first question")
      insert(:question, quiz: quiz, text: "This is the second question")
      insert(:question, quiz: quiz, text: "This is the third question")

      conn = get(conn, Routes.quiz_participation_path(conn, :show, quiz.id))

      response = html_response(conn, 200)
      assert response =~ "A simple quiz"
      assert response =~ "A quiz description"
      assert response =~ "3 questions"
    end
  end
end
