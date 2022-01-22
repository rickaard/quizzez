defmodule Quizzez.Repo.Migrations.CreateQuizzes do
  use Ecto.Migration

  def change do
    create table(:quizzes, primary_key: false) do
      add :id, :binary_id, primary_key: true, null: false
      add :title, :string
      add :description, :string
      add :category, :string
      add :user_id, references(:users, type: :binary_id, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:quizzes, [:user_id])
  end
end
