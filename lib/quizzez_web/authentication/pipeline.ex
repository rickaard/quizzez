defmodule QuizzezWeb.Authentication.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :quizzez,
    error_handler: QuizzezWeb.Authentication.ErrorHandler,
    module: QuizzezWeb.Authentication

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
