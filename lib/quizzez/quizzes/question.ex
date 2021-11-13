defmodule Quizzez.Quizzes.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :text, :string
    field :quiz_id, :id

    timestamps()

    has_many :answers, Quizzez.Quizzes.Answer
    belongs_to :quiz, Quizzez.Quizzes.Quiz, define_field: false
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
