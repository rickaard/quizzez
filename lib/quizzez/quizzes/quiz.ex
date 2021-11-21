defmodule Quizzez.Quizzes.Quiz do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quizzes" do
    field :description, :string
    field :title, :string
    field :user_id, :id

    timestamps()

    has_many :questions, Quizzez.Quizzes.Question, on_delete: :delete_all, on_replace: :delete
    belongs_to :user, Quizzez.Accounts.User, define_field: false
  end

  @doc false
  def changeset(quiz, attrs) do
    quiz
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
    |> cast_assoc(:questions, required: true)
  end
end
