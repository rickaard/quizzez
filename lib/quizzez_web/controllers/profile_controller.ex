defmodule QuizzezWeb.ProfileController do
  use QuizzezWeb, :controller

  alias Quizzez.Accounts.User
  alias Quizzez.Repo

  plug(QuizzezWeb.Plugs.RequireAuth when action in ~w[show update]a)
  plug(QuizzezWeb.Plugs.ProfileBelongsToSelf when action in ~w[show update]a)

  def show(conn, %{"id" => user_id} = _params) do
    user = Repo.get(User, user_id) |> Repo.preload(quizzes: :questions)

    case user do
      user = %User{} ->
        conn
        |> render("show.html", user: user)

      nil ->
        conn
        |> put_flash(:error, "No user found")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def update(conn, _params) do
    conn
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
