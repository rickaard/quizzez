defmodule Quizzez.Quizzes.Category do
  use Quizzez.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name, :string

    has_many :quizzes, Quizzez.Quizzes.Quiz

    timestamps()
  end

  def changeset(changeset, params) do
    changeset
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
