defmodule QuizzezWeb.Plugs.ProfileBelongsToSelf do
  @moduledoc """
  Plug that checks if the current logged in user is trying to
  reach a profile page that belongs to himself/herself or else redirect
  back to own profile page
  """
  import Plug.Conn
  import Phoenix.Controller

  alias QuizzezWeb.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    profile_id = conn.path_params["id"]
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
