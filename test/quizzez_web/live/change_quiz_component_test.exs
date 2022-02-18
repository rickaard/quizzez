defmodule QuizzezWeb.ChangeQuizComponentTest do
  use QuizzezWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias QuizzezWeb.ChangeQuizComponent

  describe "render" do
    test "renders quiz form", %{conn: conn} do
      user = insert(:user)

      {:ok, _view, html} = live_isolated(conn, ChangeQuizComponent, session: %{"user" => user})

      assert html =~ "Enter a title for the quiz"
      assert html =~ "Enter a description for the quiz"
      assert html =~ "Question #1"
      assert html =~ "Save quiz"
    end

    test "adds a question", %{conn: conn} do
      user = insert(:user)

      {:ok, view, _html} = live_isolated(conn, ChangeQuizComponent, session: %{"user" => user})

      html = render_click(view, :add_question, %{})
      assert html =~ "Question #1"
      assert html =~ "Question #2"
    end

    test "deletes a questions", %{conn: conn} do
      user = insert(:user)

      {:ok, view, _html} = live_isolated(conn, ChangeQuizComponent, session: %{"user" => user})

      assert render_click(view, :add_question, %{}) =~ "Question #2"

      refute render_click(view, :remove_question, %{"question-id" => "quiz_questions_1"}) =~
               "Question #2"
    end

    test "content in question does not get removed when deleting other question", %{conn: conn} do
      user = insert(:user)

      {:ok, view, _html} = live_isolated(conn, ChangeQuizComponent, session: %{"user" => user})

      question_params = %{
        "questions" => %{
          "0" => %{
            "text" => "What is the first question?",
            "answers" => %{
              "0" => %{"is_correct" => "false", "text" => "This is an answer!"},
              "1" => %{"is_correct" => "true", "text" => "This is a correct answer!"}
            }
          }
        }
      }

      html = render_blur(view, :validate, %{"quiz" => question_params})

      assert html =~ "What is the first question?"
      assert html =~ "This is an answer!"
      assert html =~ "This is a correct answer!"

      assert render_click(view, :add_question, %{}) =~ "Question #2"

      html = render_click(view, :remove_question, %{"question-id" => "quiz_questions_1"})

      refute html =~ "Question #2"
      assert html =~ "What is the first question?"
      assert html =~ "This is an answer!"
      assert html =~ "This is a correct answer!"
    end
  end
end
