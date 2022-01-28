defmodule QuizzezWeb.AuthController do
  use QuizzezWeb, :controller

  alias Quizzez.Accounts
  alias QuizzezWeb.Authentication

  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: %{info: user_info}}} = conn, _params) do
    case Accounts.get_or_register(user_info) do
      {:ok, user} ->
        conn
        |> Authentication.log_in(user)
        |> redirect(to: Routes.profile_path(conn, :show, user.id))

      {:error, _error_changeset} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: Routes.registration_path(conn, :new))
    end
  end

  def callback(conn, _params) do
    conn
    |> put_flash(:error, "Error signing in")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
