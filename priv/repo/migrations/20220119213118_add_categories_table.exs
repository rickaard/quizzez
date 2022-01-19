defmodule Quizzez.Repo.Migrations.AddCategoriesTable do
  use Ecto.Migration

  def change do
    create table(:categories, primary_key: false) do
      add :id, :binary_id, primary_key: true, null: false
      add :name, :string, null: false

      add :quiz_id, references(:quizzes, type: :binary_id)
    end
  end
end
