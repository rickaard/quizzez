defmodule Quizzez.Repo.Migrations.RemoveQuestionField do
  use Ecto.Migration

  def change do
    alter table(:questions) do
      remove :is_correct
    end
  end
end
