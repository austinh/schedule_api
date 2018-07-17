defmodule ScheduleApiWeb.Router do
  use ScheduleApiWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ScheduleApiWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/api", ScheduleApiWeb do
    pipe_through(:api)
  end
end
