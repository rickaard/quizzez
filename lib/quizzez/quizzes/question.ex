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

    # |> has_one_correct_answer()
  end

  def has_one_correct_answer(changeset) do
    # case Enum.any?(answers, fn answer -> answer.is_correct == true end) do
    #   true -> changeset
    #   _ -> add_error(changeset, :answers, "One answer must be correct")
    # end
    inspect(changeset, label: "has_one_correct_answer")
    changeset
  end
end
