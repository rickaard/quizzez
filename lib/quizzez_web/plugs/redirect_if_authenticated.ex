defmodule QuizzezWeb.Plugs.RedirectIfAuthenticated do
  import Plug.Conn
  import Phoenix.Controller

  alias QuizzezWeb.Router.Helpers
  alias Quizzez.Accounts.User

  def init(_params) do
  end

  def call(conn, _params) do
    user = conn.assigns[:user]

    case user do
      %User{} ->
        conn
        |> put_flash(:info, "You are already logged in..")
        |> redirect(to: Helpers.profile_path(conn, :show, user.id))
        |> halt()

      nil ->
        conn
    end
  end
end