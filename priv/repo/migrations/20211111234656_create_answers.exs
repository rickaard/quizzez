defmodule Quizzez.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers, primary_key: false) do
      add :id, :binary_id, primary_key: true, null: false
      add :text, :string
      add :is_correct, :boolean, default: false, null: false

      add :question_id, references(:questions, type: :binary_id, on_delete: :delete_all)

      timestamps()
    end

    create index(:answers, [:question_id])
  end
end
