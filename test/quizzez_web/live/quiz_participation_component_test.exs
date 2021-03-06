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

    test "shows first question when starting quiz", %{conn: conn} do
      question_1 =
        insert(:question,
          text: "This is the first question",
          answers: [
            build(:answer, is_correct: true, text: "This is first answer"),
            build(:answer, is_correct: false, text: "This is second answer")
          ]
        )

      question_2 =
        insert(:question,
          text: "This is the second question",
          answers: [
            build(:answer, is_correct: true, text: "This is first answer"),
            build(:answer, is_correct: false, text: "This is second answer")
          ]
        )

      quiz =
        insert(
          :quiz,
          title: "A simple quiz",
          description: "A quiz description",
          user: build(:user),
          questions: [question_1, question_2]
        )

      {:ok, view, _html} =
        live_isolated(conn, QuizParticipationComponent, session: %{"quiz" => quiz})

      html =
        view
        |> element("button", "Start quiz")
        |> render_click()

      refute html =~ "Start quiz"
      assert html =~ "This is the first question"
      assert html =~ "Next"
    end

    test "shows `Score` when no questions left to answer", %{conn: conn} do
      question_1 =
        insert(:question,
          text: "This is the first question",
          answers: [
            build(:answer, is_correct: true, text: "This is first answer"),
            build(:answer, is_correct: false, text: "This is second answer")
          ]
        )

      quiz =
        insert(
          :quiz,
          title: "A simple quiz",
          description: "A quiz description",
          user: build(:user),
          questions: [question_1]
        )

      {:ok, view, _html} =
        live_isolated(conn, QuizParticipationComponent, session: %{"quiz" => quiz})

      html =
        view
        |> element("button", "Start quiz")
        |> render_click()

      refute html =~ "Next question"
      assert html =~ "Score"
    end

    test "does not show `Previous` button when on first question", %{conn: conn} do
      question_1 =
        insert(:question,
          text: "This is the first question",
          answers: [
            build(:answer, is_correct: true, text: "This is first answer"),
            build(:answer, is_correct: false, text: "This is second answer")
          ]
        )

      question_2 =
        insert(:question,
          text: "This is the second question",
          answers: [
            build(:answer, is_correct: true, text: "This is first answer"),
            build(:answer, is_correct: false, text: "This is second answer")
          ]
        )

      quiz =
        insert(
          :quiz,
          title: "A simple quiz",
          description: "A quiz description",
          user: build(:user),
          questions: [question_1, question_2]
        )

      {:ok, view, _html} =
        live_isolated(conn, QuizParticipationComponent, session: %{"quiz" => quiz})

      html =
        view
        |> element("button", "Start quiz")
        |> render_click()

      assert html =~ "Next"
      refute html =~ "Previous"
    end

    test "do show `Previous` when not on first question", %{conn: conn} do
      question_1 =
        insert(:question,
          text: "This is the first question",
          answers: [
            build(:answer, is_correct: true, text: "This is first answer"),
            build(:answer, is_correct: false, text: "This is second answer")
          ]
        )

      question_2 =
        insert(:question,
          text: "This is the second question",
          answers: [
            build(:answer, is_correct: true, text: "This is first answer"),
            build(:answer, is_correct: false, text: "This is second answer")
          ]
        )

      quiz =
        insert(
          :quiz,
          title: "A simple quiz",
          description: "A quiz description",
          user: build(:user),
          questions: [question_1, question_2]
        )

      {:ok, view, _html} =
        live_isolated(conn, QuizParticipationComponent, session: %{"quiz" => quiz})

      view
      |> element("button", "Start quiz")
      |> render_click()

      view
      |> element("button", "This is first answer")
      |> render_click()

      html =
        view
        |> element("button", "Next")
        |> render_click()

      assert html =~ "Previous"
    end
  end
end
