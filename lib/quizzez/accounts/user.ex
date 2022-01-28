defmodule Quizzez.Accounts.User do
  @moduledoc false
  use Quizzez.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :provider, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string

    timestamps()

    has_many :quizzes, Quizzez.Quizzes.Quiz, on_delete: :delete_all, on_replace: :delete
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :provider, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_confirmation(:password, required: true, message: "does not match password")
    |> unique_constraint(:email)
    |> put_encrypted_password()
  end

  def oauth_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :provider, :email])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end

  defp put_encrypted_password(%{valid?: true, changes: %{password: pw}} = changeset) do
    put_change(changeset, :encrypted_password, Argon2.hash_pwd_salt(pw))
  end

  defp put_encrypted_password(changeset) do
    changeset
  end
end
