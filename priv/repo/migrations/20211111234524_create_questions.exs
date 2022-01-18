defmodule Quizzez.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :string
      add :is_correct, :boolean, default: false, null: false
      add :quiz_id, references(:quizzes, type: :binary_id, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:questions, [:quiz_id])
  end
end
