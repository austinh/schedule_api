defmodule ScheduleApiWeb.Router do
  use ScheduleApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ScheduleApiWeb do
    pipe_through :api
  end
end
