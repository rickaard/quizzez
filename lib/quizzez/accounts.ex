defmodule Quizzez.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Quizzez.Repo

  alias Quizzez.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user.

  Returns nil if no user is found

  ## Examples

      iex> get_user(123)
      %User{}

      iex> get_user(456)
      nil
  """
  def get_user(id), do: Repo.get(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> register(%{field: value})
      {:ok, %User{}}

      iex> register(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def register(%Ueberauth.Auth.Info{} = user_params) do
    %User{}
    |> User.oauth_changeset(extract_user_params(user_params))
    |> Repo.insert()
  end

  def register(user_params) do
    %User{}
    |> User.changeset(user_params)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def update_user(%User{provider: provider} = user, attrs) when not is_nil(provider) do
    user
    |> User.oauth_changeset(attrs)
    |> Repo.update()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(user \\ %User{}, params \\ %{}) do
    User.changeset(user, params)
  end

  @doc """
  Gets a single user by email.

  Returns nil if no user is found

  ## Examples

      iex> get_user("name@example.com")
      %User{}

      iex> get_user("notfound@example.com")
      nil
  """
  def get_by_email(email) do
    Repo.get_by(User, email: email)
  end

  @doc """
  Either returns an existing user or tries to create a new user

  ## Examples

      iex> get_or_register(%{field: value})
      {:ok, user}

      iex> get_or_register(%{field: bad_value})
      {:error, changeset}

  """
  def get_or_register(%Ueberauth.Auth.Info{email: email} = user_params) do
    if user = get_by_email(email) do
      {:ok, user}
    else
      register(user_params)
    end
  end

  defp extract_user_params(%Ueberauth.Auth.Info{} = user_info, provider \\ "google") do
    %{
      email: user_info.email,
      name: user_info.name || "Anonymous",
      provider: provider
    }
  end
end
