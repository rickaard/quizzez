defmodule Quizzez.QuizzesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Quizzez.Quizzes` context.
  """

  @doc """
  Generate a quiz.
  """
  def quiz_fixture(attrs \\ %{}) do
    {:ok, quiz} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> Quizzez.Quizzes.create_quiz()

    quiz
  end

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        is_correct: true,
        text: "some text"
      })
      |> Quizzez.Quizzes.create_question()

    question
  end

  @doc """
  Generate a answer.
  """
  def answer_fixture(attrs \\ %{}) do
    {:ok, answer} =
      attrs
      |> Enum.into(%{
        is_correct: true,
        text: "some text"
      })
      |> Quizzez.Quizzes.create_answer()

    answer
  end
end
