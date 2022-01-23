defmodule QuizzezWeb.AuthController do
  use QuizzezWeb, :controller

  alias Quizzez.Accounts.User
  alias Quizzez.Repo

  plug(QuizzezWeb.Plugs.RedirectIfAuthenticated when action not in ~w[sign_out]a)
  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: %{info: user_info}}} = conn, %{"provider" => provider}) do
    user_params = %{
      email: user_info.email,
      name: user_info.name || "Anonymous",
      provider: provider || "unknown"
    }

    changeset = User.changeset(%User{}, user_params)

    sign_in(conn, changeset)
  end

  def callback(conn, _params) do
    conn
    |> put_flash(:error, "Error signing in")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def sign_out(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp sign_in(conn, changeset) do
    case insert_or_get_user(changeset) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.profile_path(conn, :show, user.id))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  defp insert_or_get_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)

      user ->
        {:ok, user}
    end
  end
end
