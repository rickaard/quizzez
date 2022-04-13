defmodule QuizzezWeb.SessionController do
  use QuizzezWeb, :controller

  alias Quizzez.Accounts
  alias Quizzez.Accounts.User
  alias QuizzezWeb.Authentication

  def new(conn, _params) do
    user = Authentication.get_current_user(conn)

    if user do
      redirect(conn, to: Routes.profile_path(conn, :show, user.id))
    else
      changeset = Accounts.change_user()

      conn
      |> Metatags.put("title", "Login")
      |> Metatags.put("description", "Login to you account at quizzez.app")
      |> render("new.html", changeset: changeset, action: Routes.session_path(conn, :create))
    end
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with %User{} = user <- Accounts.get_by_email(email),
         {:ok, user} <- Authentication.authenticate(user, password) do
      conn
      |> Authentication.log_in(user)
      |> redirect(to: Routes.profile_path(conn, :show, user.id))
    else
      {:error, :invalid_credentials} ->
        conn
        |> put_flash(:error, "Incorrect email or password")
        |> new(%{})

      {:error, :invalid_strategy} ->
        conn
        |> put_flash(
          :error,
          "Your account was created with Google. Please use that login method."
        )
        |> new(%{})

      nil ->
        conn
        |> put_flash(:error, "Incorrect email or password")
        |> new(%{})
    end
  end

  def delete(conn, _params) do
    conn
    |> Authentication.log_out()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
