defmodule QuizzezWeb.Authentication do
  @moduledoc """
  Implementation module for Guardian and functions for authentication.
  """

  use Guardian, otp_app: :quizzez

  alias Quizzez.Accounts
  alias Quizzez.Accounts.User

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end

  def log_in(conn, user) do
    __MODULE__.Plug.sign_in(conn, user)
  end

  def log_out(conn) do
    __MODULE__.Plug.sign_out(conn)
  end

  def get_current_user(conn) do
    __MODULE__.Plug.current_resource(conn)
  end

  def authenticate(%User{} = user, password) do
    authenticate(user, password, Argon2.verify_pass(password, user.encrypted_password))
  end

  def authenticate(nil, password) do
    authenticate(nil, password, Argon2.no_user_verify())
  end

  def authenticate(account, _password, true) do
    {:ok, account}
  end

  def authenticate(_account, _password, false) do
    {:error, :invalid_credentials}
  end

  def logged_in?(conn) do
    case get_current_user(conn) do
      %User{} ->
        true

      nil ->
        false
    end
  end
end
