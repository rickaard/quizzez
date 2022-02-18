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

      assert render_click(view, :add_question, %{}) =~ "Question #2"
    end

    test "deletes a questions", %{conn: conn} do
      user = insert(:user)

      {:ok, view, _html} = live_isolated(conn, ChangeQuizComponent, session: %{"user" => user})

      assert render_click(view, :add_question, %{}) =~ "Question #2"

      refute render_click(view, :remove_question, %{"question-id" => "quiz_questions_1"}) =~
               "Question #2"
    end
  end
end
