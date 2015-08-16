defmodule Kegster.Router do
  use Kegster.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Kegster do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
  end

  scope "/auth", Kegster do
    get "/", AuthController, :index
    get "/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  scope "/api", Kegster do
    pipe_through :api
    resources "/kegerators", API.KegeratorController
    resources "/kegs", API.KegController
  end
end
