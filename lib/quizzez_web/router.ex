defmodule QuizzezWeb.Router do
  use QuizzezWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :guardian do
    plug QuizzezWeb.Authentication.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/auth", QuizzezWeb do
    pipe_through [:browser, :guardian, QuizzezWeb.Plugs.RedirectIfAuthenticated]

    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :callback)
    post("/:provider/callback", AuthController, :callback)
    post("/identity/callback", AuthController, :identity_callback)
  end

  scope "/", QuizzezWeb do
    pipe_through [:browser, :guardian, QuizzezWeb.Plugs.RedirectIfAuthenticated]

    get("/register", RegistrationController, :new)
    post("/register", RegistrationController, :create)
    get("/login", SessionController, :new)
  end

  # Authenticated routes
  scope "/", QuizzezWeb do
    pipe_through [:browser, :guardian, :ensure_auth]

    resources("/profile", ProfileController, only: ~w[show update]a)
    delete("/logout", SessionController, :delete)
  end

  scope "/", QuizzezWeb do
    pipe_through [:browser, :guardian]

    resources("/quiz", QuizController, only: ~w[new edit]a) do
      resources("/participation", Quiz.ParticipationController, only: ~w[show]a, singleton: true)
    end

    resources("/categories", CategoryController)

    post("/login", SessionController, :create)

    resources("/", PageController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", QuizzezWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through(:browser)
      live_dashboard("/dashboard", metrics: QuizzezWeb.Telemetry)
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through(:browser)

      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
