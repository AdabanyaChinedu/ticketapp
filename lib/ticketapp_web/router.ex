defmodule TicketappWeb.Router do
  use TicketappWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TicketappWeb do
    pipe_through :browser

    get "/", TicketController, :index
    resources "/tickets", TicketController
  end

  # Other scopes may use custom stacks.
  scope "/api", TicketappWeb do
    pipe_through :api

    get "/tickets", TicketController, :index_api
  end
end
