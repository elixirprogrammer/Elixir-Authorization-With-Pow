defmodule AuthorizationWithPowWeb.Router do
  use AuthorizationWithPowWeb, :router
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword, PowEmailConfirmation]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AuthorizationWithPowWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :not_authenticated do
    plug Pow.Plug.RequireNotAuthenticated,
      error_handler: AuthorizationWithPowWeb.AuthErrorHandler
  end

  scope "/", AuthorizationWithPowWeb do
    pipe_through :browser


    live "/", PageLive, :index
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  scope "/", AuthorizationWithPowWeb do
    pipe_through [:browser, :not_authenticated]


    post "/signup", RegistrationController, :create, as: :signup
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
  end

  scope "/u", AuthorizationWithPowWeb do
    pipe_through :browser

    get "/:username", UserController, :profile, as: :user
  end



  scope "/", AuthorizationWithPowWeb do
    pipe_through [:browser, :protected]
    # Add your protected routes here

  end




  # Other scopes may use custom stacks.
  # scope "/api", AuthorizationWithPowWeb do
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
      pipe_through :browser
      live_dashboard "/dashboard", metrics: AuthorizationWithPowWeb.Telemetry
    end
  end
end
