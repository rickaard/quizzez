defmodule Quizzez.QuizzesTest do
  use Quizzez.DataCase

  alias Quizzez.Quizzes

  describe "quizzes" do
    alias Quizzez.Quizzes.Quiz

    import Quizzez.QuizzesFixtures

    @invalid_attrs %{description: nil, title: nil}

    test "list_quizzes/0 returns all quizzes" do
      quiz = quiz_fixture()
      assert Quizzes.list_quizzes() == [quiz]
    end

    test "get_quiz!/1 returns the quiz with given id" do
      quiz = quiz_fixture()
      assert Quizzes.get_quiz!(quiz.id) == quiz
    end

    test "create_quiz/1 with valid data creates a quiz" do
      valid_attrs = %{description: "some description", title: "some title"}

      assert {:ok, %Quiz{} = quiz} = Quizzes.create_quiz(valid_attrs)
      assert quiz.description == "some description"
      assert quiz.title == "some title"
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
      assert quiz == Quizzes.get_quiz!(quiz.id)
    end

    test "delete_quiz/1 deletes the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{}} = Quizzes.delete_quiz(quiz)
      assert_raise Ecto.NoResultsError, fn -> Quizzes.get_quiz!(quiz.id) end
    end

    test "change_quiz/1 returns a quiz changeset" do
      quiz = quiz_fixture()
      assert %Ecto.Changeset{} = Quizzes.change_quiz(quiz)
    end
  end

  describe "questions" do
    alias Quizzez.Quizzes.Question

    import Quizzez.QuizzesFixtures

    @invalid_attrs %{is_correct: nil, text: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Quizzes.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Quizzes.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{is_correct: true, text: "some text"}

      assert {:ok, %Question{} = question} = Quizzes.create_question(valid_attrs)
      assert question.is_correct == true
      assert question.text == "some text"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quizzes.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{is_correct: false, text: "some updated text"}

      assert {:ok, %Question{} = question} = Quizzes.update_question(question, update_attrs)
      assert question.is_correct == false
      assert question.text == "some updated text"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Quizzes.update_question(question, @invalid_attrs)
      assert question == Quizzes.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Quizzes.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Quizzes.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Quizzes.change_question(question)
    end
  end

  describe "answers" do
    alias Quizzez.Quizzes.Answer

    import Quizzez.QuizzesFixtures

    @invalid_attrs %{is_correct: nil, text: nil}

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Quizzes.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Quizzes.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      valid_attrs = %{is_correct: true, text: "some text"}

      assert {:ok, %Answer{} = answer} = Quizzes.create_answer(valid_attrs)
      assert answer.is_correct == true
      assert answer.text == "some text"
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quizzes.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      update_attrs = %{is_correct: false, text: "some updated text"}

      assert {:ok, %Answer{} = answer} = Quizzes.update_answer(answer, update_attrs)
      assert answer.is_correct == false
      assert answer.text == "some updated text"
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Quizzes.update_answer(answer, @invalid_attrs)
      assert answer == Quizzes.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Quizzes.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Quizzes.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Quizzes.change_answer(answer)
    end
  end
end
