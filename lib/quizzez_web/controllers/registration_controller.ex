defmodule QuizzezWeb.RegistrationController do
  use QuizzezWeb, :controller

  plug Ueberauth

  alias Quizzez.Accounts
  alias QuizzezWeb.Authentication

  def new(conn, _params) do
    changeset = Accounts.change_user()

    render(conn, "new.html",
      changeset: changeset,
      action: Routes.registration_path(conn, :create)
    )
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register(user_params) do
      {:ok, user} ->
        conn
        |> Authentication.log_in(user)
        |> redirect(to: Routes.profile_path(conn, :show, user.id))

      {:error, changeset} ->
        render(conn, "new.html",
          changeset: changeset,
          action: Routes.registration_path(conn, :create)
        )
    end
  end
end
