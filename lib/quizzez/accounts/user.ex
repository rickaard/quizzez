defmodule Quizzez.Accounts.User do
  use Quizzez.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :provider, :string

    timestamps()

    has_many :quizzes, Quizzez.Quizzes.Quiz
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :provider, :email])
    |> validate_required([:name, :provider, :email])
    |> unique_constraint(:email)
  end
end
