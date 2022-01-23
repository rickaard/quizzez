defmodule QuizzezWeb.Authentication.Pipeline do
  @moduledoc """
  Plug to handle authentication with the help from `Guardian`
  """
  use Guardian.Plug.Pipeline,
    otp_app: :quizzez,
    error_handler: QuizzezWeb.Authentication.ErrorHandler,
    module: QuizzezWeb.Authentication

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
