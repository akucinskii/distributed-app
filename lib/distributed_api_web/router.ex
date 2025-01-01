defmodule DistributedApiWeb.Router do
  use DistributedApiWeb, :router

  import DistributedApiWeb.UserAuth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {DistributedApiWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:fetch_current_user)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", DistributedApiWeb do
    pipe_through(:browser)

    resources("/items", ItemController)
    resources("/boxes", BoxController)
    get("/", PageController, :home)
  end

  # Other scopes may use custom stacks.
  # scope "/api", DistributedApiWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:distributed_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: DistributedApiWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end

  ## Authentication routes

  scope "/", DistributedApiWeb do
    pipe_through([:browser, :redirect_if_user_is_authenticated])

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{DistributedApiWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post("/users/log_in", UserSessionController, :create)
  end

  scope "/", DistributedApiWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{DistributedApiWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
      live "/boxes_live", BoxLive.Index, :index
      live "/boxes_live/new", BoxLive.Index, :new
      live "/boxes_live/:id/edit", BoxLive.Index, :edit

      live "/boxes_live/:id", BoxLive.Show, :show
      live "/boxes_live/:id/show/edit", BoxLive.Show, :edit

      live "/items_live", ItemLive.Index, :index
      live "/items_live/new", ItemLive.Index, :new
      live "/items_live/:id/edit", ItemLive.Index, :edit

      live "/items_live/:id", ItemLive.Show, :show
      live "/items_live/:id/show/edit", ItemLive.Show, :edit
    end
  end

  scope "/", DistributedApiWeb do
    pipe_through([:browser])

    delete("/users/log_out", UserSessionController, :delete)

    live_session :current_user,
      on_mount: [{DistributedApiWeb.UserAuth, :mount_current_user}] do
      live("/users/confirm/:token", UserConfirmationLive, :edit)
      live("/users/confirm", UserConfirmationInstructionsLive, :new)
    end
  end
end
