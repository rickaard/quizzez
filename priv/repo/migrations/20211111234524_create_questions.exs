defmodule Quizzez.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :text, :string
      add :is_correct, :boolean, default: false, null: false
      add :quiz_id, references(:quizzes, on_delete: :delete_all)

      timestamps()
    end

    create index(:questions, [:quiz_id])
  end
end
