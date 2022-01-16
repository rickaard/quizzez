defmodule QuizzezWeb.Plugs.ProfileBelongsToSelf do
  import Plug.Conn
  import Phoenix.Controller

  alias QuizzezWeb.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    profile_id = conn.path_params["id"] |> String.to_integer()
    user = conn.assigns[:user]

    if profile_id == user.id do
      conn
    else
      conn
      |> put_flash(:error, "You're not allowed to go there")
      |> redirect(to: Helpers.profile_path(conn, :show, user.id))
      |> halt()
    end
  end
end
