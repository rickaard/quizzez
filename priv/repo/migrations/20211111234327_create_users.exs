defmodule Quizzez.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true, null: false
      add :name, :string
      add :email, :citext, null: false
      add :provider, :string
      add :encrypted_password, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
