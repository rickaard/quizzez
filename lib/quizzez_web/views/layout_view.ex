defmodule QuizzezWeb.LayoutView do
  use QuizzezWeb, :view

  alias QuizzezWeb.SVGHelpers
  alias QuizzezWeb.Authentication
  alias Quizzez.Accounts.User

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def user_name(conn) do
    %User{name: name} = Authentication.get_current_user(conn)

    name
  end
end
