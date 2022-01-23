defmodule QuizzezWeb.Authentication.ErrorHandler do
  @moduledoc """
  Module that handles auth_errors, i.e when authentication is not successfull
  """
  use QuizzezWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_flash(:error, "You must be logged in to visit that page")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
