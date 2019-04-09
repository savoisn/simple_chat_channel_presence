defmodule SimpleChatWeb.Router do
  use SimpleChatWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", SimpleChatWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    post("/", PageController, :define_user)
    delete("/", PageController, :disconnect_user)
    resources("/messages", MessageController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", SimpleChatWeb do
  #   pipe_through :api
  # end
end
