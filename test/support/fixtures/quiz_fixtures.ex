defmodule Quizzez.QuizFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Quizzez.Quiz` context.
  """

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
      |> Quizzez.Quiz.create_answer()

    answer
  end

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        text: "some text"
      })
      |> Quizzez.Quiz.create_question()

    question
  end
end
