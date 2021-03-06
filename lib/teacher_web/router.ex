defmodule TeacherWeb.Router do
  use TeacherWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json", "x-www-form-urlencoded"]
  end

  scope "/", TeacherWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/posts", PostController do
      resources "/comments", CommentController, only: [:create]
    end
  end

  scope "/owen", TeacherWeb do
    pipe_through :api

    resources "/transactions", TransactionController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TeacherWeb do
  #   pipe_through :api
  # end
end
