defmodule Quizzez.Quizzes.Quiz do
  @moduledoc false
  use Quizzez.Schema
  import Ecto.Changeset

  @categories ~w[food geography history math misc music programming science workout]

  schema "quizzes" do
    field :description, :string
    field :title, :string
    field :category, :string

    timestamps()

    has_many :questions, Quizzez.Quizzes.Question, on_delete: :delete_all, on_replace: :delete
    belongs_to :user, Quizzez.Accounts.User
  end

  @doc false
  def changeset(quiz, attrs) do
    quiz
    |> cast(attrs, [:title, :description, :category])
    |> validate_required([:title, :description, :category])
    |> validate_inclusion(:category, @categories)
    |> cast_assoc(:questions, required: true)
  end
end
