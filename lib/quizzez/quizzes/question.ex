defmodule Quizzez.Quizzes.Question do
  @moduledoc false
  use Quizzez.Schema
  import Ecto.Changeset

  schema "questions" do
    field :text, :string

    timestamps()

    has_many :answers, Quizzez.Quizzes.Answer, on_delete: :delete_all, on_replace: :delete
    belongs_to :quiz, Quizzez.Quizzes.Quiz
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:text])
    |> validate_required([:text])
    |> cast_assoc(:answers, required: true)
    |> has_one_correct_answer()
  end

  def has_one_correct_answer(changeset) do
    case correct_answers_amount(changeset) do
      0 -> add_error(changeset, :question, "does not have any correct answer")
      1 -> changeset
      _ -> add_error(changeset, :question, "must only have one correct answer")
    end
  end

  def correct_answers_amount(changeset) do
    answers = get_field(changeset, :answers)

    Enum.count(answers, & &1.is_correct)
  end
end
