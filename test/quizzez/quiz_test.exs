defmodule Quizzez.QuizTest do
  use Quizzez.DataCase

  alias Quizzez.Quizzes

  describe "quizzes" do
    import Quizzez.QuizFixtures
    alias Quizzez.Quizzes.Quiz

    @invalid_attrs %{description: nil, title: nil}

    test "create_quiz with no questions or answer data is not valid" do
      question_one =
        Map.put(%{text: ""}, :answers, [
          %{text: "2020", is_correct: false},
          %{text: "2021", is_correct: true}
        ])

      full_quiz =
        Map.put(%{title: "quiz title", description: "quiz description"}, :questions, [
          question_one
        ])

      changeset = Quiz.changeset(%Quiz{}, full_quiz)
      IO.inspect(changeset)
      refute changeset.valid?
    end

    test "list_quizzes/0 returns all quizzes" do
      quiz = quiz_fixture()
      assert Quizzes.list_quizzes_with_questions_and_answers() == [quiz]
    end

    test "get_quiz_with_questions_and_answers returns the quiz with given id" do
      quiz = quiz_fixture()
      assert Quizzes.get_quiz_with_questions_and_answers(quiz.id) == quiz
    end

    test "create_quiz/1 with valid data creates a quiz" do
      answer = %{text: "This is an answer", is_correct: true}
      question = %{text: "What is a question?", answers: [answer]}
      valid_attrs = %{description: "some description", title: "some title", questions: [question]}

      assert {:ok, %Quiz{} = quiz} = Quizzes.create_quiz(valid_attrs)
      assert quiz.description == "some description"
      assert quiz.title == "some title"
      assert "What is a question?" = quiz.questions |> List.first() |> Map.get(:text)

      assert "This is an answer" =
               quiz.questions
               |> List.first()
               |> Map.get(:answers)
               |> List.first()
               |> Map.get(:text)
    end

    test "create_quiz/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quizzes.create_quiz(@invalid_attrs)
    end

    test "update_quiz/2 with valid data updates the quiz" do
      quiz = quiz_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title"}

      assert {:ok, %Quiz{} = quiz} = Quizzes.update_quiz(quiz, update_attrs)
      assert quiz.description == "some updated description"
      assert quiz.title == "some updated title"
    end

    test "update_quiz/2 with invalid data returns error changeset" do
      quiz = quiz_fixture()
      assert {:error, %Ecto.Changeset{}} = Quizzes.update_quiz(quiz, @invalid_attrs)
      assert quiz == Quizzes.get_quiz_with_questions_and_answers(quiz.id)
    end

    # test "delete_quiz/1 deletes the quiz" do
    #   quiz = quiz_fixture()
    #   assert {:ok, %Quiz{}} = Quizzes.delete_quiz(quiz)
    #   assert_raise Ecto.NoResultsError, fn -> Quizzes.get_quiz!(quiz.id) end
    # end

    test "change_quiz/1 returns a quiz changeset" do
      quiz = quiz_fixture()
      assert %Ecto.Changeset{} = Quizzes.change_quiz(quiz)
    end
  end
end
