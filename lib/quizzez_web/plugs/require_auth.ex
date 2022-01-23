defmodule QuizzezWeb.Plugs.RequireAuth do
  @moduledoc """
  Plug to see if a user exists on the `conn`
  or redirect to homepage

  Used to protect pages where a user must be logged in
  """
  import Plug.Conn
  import Phoenix.Controller

  alias QuizzezWeb.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in for that page")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end
end
