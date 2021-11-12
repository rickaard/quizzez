defmodule Quizzez.Quizzes.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    field :is_correct, :boolean, default: false
    field :text, :string
    field :question_id, :id

    timestamps()

    belongs_to :question, Quizzez.Quizzes.Question, define_field: false
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:text, :is_correct])
    |> validate_required([:text, :is_correct])
  end
end
