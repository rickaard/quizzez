defmodule Quizzez.QuizTest do
  use Quizzez.DataCase, async: true

  alias Quizzez.Quizzes

  describe "quizzes" do
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
      refute changeset.valid?
    end

    test "list_quizzes/0 returns all quizzes" do
      quiz = insert(:quiz, user: build(:user))
      assert Quizzes.list_quizzes_with_questions_and_answers() == [quiz]
    end

    test "get_quiz_with_questions_and_answers returns the quiz with given id" do
      answer = insert(:answer)
      question = insert(:question, answers: [answer])

      quiz = insert(:quiz, questions: [question])

      assert Quizzes.get_quiz_with_questions_and_answers(quiz.id) == quiz
    end

    test "create_quiz/1 with valid data creates a quiz" do
      answer = %{text: "This is an answer", is_correct: true}
      question = %{text: "What is a question?", answers: [answer]}

      valid_attrs = %{
        description: "some description",
        title: "some title",
        category: "misc",
        questions: [question]
      }

      assert {:ok, %Quiz{} = quiz} = Quizzes.create_quiz(valid_attrs)
      assert quiz.description == "some description"
      assert quiz.title == "some title"
      assert quiz.category == "misc"
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

    test "create quiz with a question without any correct answer returns error changeset" do
      user = insert(:user)

      question = %{
        text: "This is a question",
        answers: [
          %{text: "This is a false answer", is_correct: false},
          %{text: "This is also a false answer", is_correct: false}
        ]
      }

      quiz = %{
        title: "quiz title",
        description: "some description",
        category: "misc",
        questions: [question]
      }

      changeset =
        user
        |> Ecto.build_assoc(:quizzes)
        |> Quiz.changeset(quiz)

      refute changeset.valid?

      assert %{questions: [%{question: ["does not have any correct answer"]}]} =
               errors_on(changeset)

      assert {:error, _} = Repo.insert(changeset)
      assert [] = Repo.all(Quiz)
    end

    test "create quiz with a question with more than 1 correct answer returns error changeset" do
      user = insert(:user)

      question = %{
        text: "This is a question",
        answers: [
          %{text: "This is a correct answer", is_correct: true},
          %{text: "This is also a correct answer", is_correct: true}
        ]
      }

      quiz = %{
        title: "quiz title",
        description: "some description",
        category: "misc",
        questions: [question]
      }

      changeset =
        user
        |> Ecto.build_assoc(:quizzes)
        |> Quiz.changeset(quiz)

      refute changeset.valid?

      assert %{questions: [%{question: ["must only have one correct answer"]}]} =
               errors_on(changeset)

      assert {:error, _} = Repo.insert(changeset)
      assert [] = Repo.all(Quiz)
    end

    test "update_quiz/2 with valid data updates the quiz" do
      question = insert(:question)
      quiz = insert(:quiz, questions: [question])

      update_attrs = %{
        description: "some updated description",
        title: "some updated title",
        catgegory: "misc"
      }

      assert {:ok, %Quiz{} = quiz} = Quizzes.update_quiz(quiz, update_attrs)
      assert quiz.description == "some updated description"
      assert quiz.title == "some updated title"
      assert quiz.category == "misc"
    end

    test "update_quiz/2 with invalid data returns error changeset" do
      quiz = insert(:quiz)
      assert {:error, %Ecto.Changeset{}} = Quizzes.update_quiz(quiz, @invalid_attrs)
      assert quiz == Quizzes.get_quiz!(quiz.id)
    end

    test "delete_quiz/1 deletes the quiz" do
      quiz = insert(:quiz)
      assert {:ok, %Quiz{}} = Quizzes.delete_quiz(quiz)
      assert_raise Ecto.NoResultsError, fn -> Quizzes.get_quiz!(quiz.id) end
    end

    test "change_quiz/1 returns a quiz changeset" do
      quiz = insert(:quiz, user: build(:user))
      assert %Ecto.Changeset{} = Quizzes.change_quiz(quiz)
    end

    test "list_quizzez_with_questions_from_category/1" do
      user = insert(:user)
      insert(:quiz, user: user, category: "misc")
      insert(:quiz, user: user, category: "misc")
      insert(:quiz, user: user, category: "music")

      assert 2 = length(Quizzes.list_quizzez_with_questions_from_category("misc"))
      assert 1 = length(Quizzes.list_quizzez_with_questions_from_category("music"))
      assert [] = Quizzes.list_quizzez_with_questions_from_category("food")
    end
  end

  describe "quiz participation" do
    test "calculates correct answers" do
      answer_1 = insert(:answer, is_correct: false, text: "This is false")
      answer_2 = insert(:answer, is_correct: true, text: "This is correct")
      answer_3 = insert(:answer, is_correct: false, text: "This is also false")

      question_1 =
        insert(:question,
          text: "This is the first question",
          answers: [answer_1, answer_2, answer_3]
        )

      answer_3 = insert(:answer, is_correct: false, text: "This is also false")
      answer_4 = insert(:answer, is_correct: false, text: "This is also false")
      answer_5 = insert(:answer, is_correct: true, text: "This is also correct")

      question_2 =
        insert(
          :question,
          text: "This is the second question",
          answers: [answer_3, answer_4, answer_5]
        )

      answer_6 = insert(:answer, is_correct: false, text: "This is also false")
      answer_7 = insert(:answer, is_correct: true, text: "This is correct")

      question_3 =
        insert(
          :question,
          text: "This is the third question",
          answers: [answer_6, answer_7]
        )

      quiz =
        insert(
          :quiz,
          title: "A simple quiz",
          description: "A quiz description",
          user: build(:user),
          questions: [question_1, question_2, question_3]
        )

      answers = [
        %{answer_id: answer_5.id, question_id: question_2.id},
        %{answer_id: answer_1.id, question_id: question_1.id},
        %{answer_id: answer_7.id, question_id: question_3.id}
      ]

      assert 2 = Quizzes.calculate_score(quiz, answers)
    end
  end
end
