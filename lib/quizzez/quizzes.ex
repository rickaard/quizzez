defmodule Quizzez.Quizzes do
  @moduledoc """
  The Quizzes context.

  A collection of functions related to quizzes
  """

  import Ecto.Query, warn: false
  alias Quizzez.Repo

  alias Quizzez.Quizzes.Quiz
  alias Quizzez.Quizzes.Question

  @doc """
  Returns the list of quizzes.

  ## Examples

      iex> list_quizzes()
      [%Quiz{}, ...]

  """
  def list_quizzes do
    Repo.all(Quiz)
  end

  @doc """
  Returns a list of quizzes with related questions preloaded

  Examples

    iex> list_quizzes_with_questions()
    [%Quiz{questions: [%Question{}, ...]}, ...]
  """
  def list_quizzes_with_questions do
    Quiz
    |> Repo.all()
    |> Repo.preload(:questions)
  end

  @doc """
  Returns a list of quizzes with related questions preloaded aswell as related answers preloaded to the questions

  Examples

    iex> list_quizzes_with_questions_and_answers()
    [
      %Quiz{
        questions: [
          %Question{
            answers: [
              %Answer{},
              ...
            ]
          },
          ...
        ]
      },
    ...]
  """
  def list_quizzes_with_questions_and_answers do
    Quiz
    |> Repo.all()
    |> Repo.preload(questions: :answers)
  end

  @doc """
  Returns a list of questions with answers preloaded

  Examples

    iex> list_questions_with_answers()
    [%Question{answers: [%Answers{}, ...]}, ...]
  """
  def list_questions_with_answers do
    Question
    |> Repo.all()
    |> Repo.preload([:answers])
  end

  @doc """
  Gets a single quiz with questions and answers preloaded

  Returns `nil` if no quiz with that ID is found

  Examples

    iex> get_quiz_with_questions_and_answers("a-valid-binary-id")
    %Quiz{}

    iex> get_quiz_with_questions_and_answers("a-valid-binary-id")
    nil
  """
  def get_quiz_with_questions_and_answers(id) do
    Quiz
    |> Repo.get(id)
    |> Repo.preload(questions: :answers)
  end

  @doc """
  Gets a single question with answers preloaded

  Returns `nil` if no question with that ID is found

  Examples

    iex> get_question_with_answers("a-valid-binary-id")
    %Question{}

    iex> get_question_with_answers("a-valid-binary-id")
    nil
  """
  def get_question_with_answers(id) do
    Question
    |> Repo.get(id)
    |> Repo.preload(:answers)
  end

  @doc """
  Gets a single quiz.

  Raises `Ecto.NoResultsError` if the Quiz does not exist.

  ## Examples

      iex> get_quiz!(123)
      %Quiz{}

      iex> get_quiz!(456)
      ** (Ecto.NoResultsError)

  """
  def get_quiz!(id), do: Repo.get!(Quiz, id)

  @doc """
  Creates a quiz.

  ## Examples

      iex> create_quiz(%{field: value})
      {:ok, %Quiz{}}

      iex> create_quiz(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_quiz(attrs \\ %{}) do
    %Quiz{}
    |> Quiz.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a quiz.

  ## Examples

      iex> update_quiz(quiz, %{field: new_value})
      {:ok, %Quiz{}}

      iex> update_quiz(quiz, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_quiz(%Quiz{} = quiz, attrs) do
    quiz
    |> Quiz.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a quiz.

  ## Examples

      iex> delete_quiz(quiz)
      {:ok, %Quiz{}}

      iex> delete_quiz(quiz)
      {:error, %Ecto.Changeset{}}

  """
  def delete_quiz(%Quiz{} = quiz) do
    {:ok}
    Repo.delete(quiz)
  end

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
  end
end
