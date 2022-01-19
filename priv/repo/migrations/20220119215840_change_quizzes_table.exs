defmodule Quizzez.Repo.Migrations.ChangeQuizzesTable do
  use Ecto.Migration

  def change do
    alter table(:quizzes) do
      add :category_id, references(:categories, type: :binary_id)
    end
  end
end
