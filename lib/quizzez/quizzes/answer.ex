defmodule Quizzez.Quizzes.Answer do
  use Quizzez.Schema
  import Ecto.Changeset

  schema "answers" do
    field :is_correct, :boolean, default: false
    field :text, :string

    timestamps()

    belongs_to :question, Quizzez.Quizzes.Question
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:text, :is_correct])
    |> validate_required([:text, :is_correct])
  end
end
