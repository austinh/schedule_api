defmodule ScheduleApiWeb.PageController do
  use ScheduleApiWeb, :controller

  def index(conn, _params) do
    text(conn, "Welcome to the WeWork Schedule API.")
  end
end
