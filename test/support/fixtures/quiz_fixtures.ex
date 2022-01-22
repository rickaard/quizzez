defmodule Quizzez.QuizFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Quizzez.Quiz` context.
  """

  @doc """
  Generate a quiz.
  """
  def quiz_fixture(attrs \\ %{}) do
    {:ok, quiz} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title",
        category: "some category",
        questions: [
          %{
            text: "some text",
            answers: [
              %{text: "2020", is_correct: false},
              %{text: "2021", is_correct: true}
            ]
          }
        ]
      })
      |> Quizzez.Quizzes.create_quiz()

    quiz
  end
end
