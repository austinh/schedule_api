defmodule ScheduleApi.PageController do
  use ScheduleApi, :controller

  def index(conn, _params) do
    text conn, "Welcome to the WeWork Schedule API."
  end
end
