defmodule QuizzezWeb.AuthController do
  use QuizzezWeb, :controller

  alias Quizzez.Accounts
  alias QuizzezWeb.Authentication

  plug Ueberauth

  # def callback(%{assigns: %{ueberauth_auth: %{info: user_info}}} = conn, %{"provider" => provider}) do
  #   user_params = %{
  #     email: user_info.email,
  #     name: user_info.name || "Anonymous",
  #     provider: provider || "unknown"
  #   }

  #   changeset = User.changeset(%User{}, user_params)

  #   sign_in(conn, changeset)
  # end
  def callback(%{assigns: %{ueberauth_auth: %{info: user_info}}} = conn, %{
        "provider" => _provider
      }) do
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
