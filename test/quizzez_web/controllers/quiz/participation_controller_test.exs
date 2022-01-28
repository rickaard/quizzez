defmodule QuizzezWeb.Survey.ParticipationControllerTest do
  use QuizzezWeb.ConnCase

  describe "GET /" do
    test "renders quiz details", %{conn: conn} do
      quiz =
        insert(
          :quiz,
          title: "A simple quiz",
          description: "A quiz description",
          user: build(:user)
        )

      conn = get(conn, Routes.quiz_participation_path(conn, :show, quiz.id))

      response = html_response(conn, 200)
      assert response =~ "A simple quiz"
      assert response =~ "A quiz description"
    end
  end
end
