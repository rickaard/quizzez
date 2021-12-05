defmodule QuizzezWeb.AuthController do
  use QuizzezWeb, :controller

  alias Quizzez.Accounts.User
  alias Quizzez.Repo

  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: %{info: user_info}}} = conn, %{"provider" => "google"}) do
    user_params = %{
      email: user_info.email,
      name: user_info.name || "Anonymous",
      provider: "google"
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
        |> put_flash(:info, "Welcome!")
        |> put_session(:user_id, user.id)
        # Change this to Profile page
        |> redirect(to: Routes.page_path(conn, :index))

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
