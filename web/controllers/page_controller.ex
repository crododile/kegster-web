defmodule Kegster.PageController do
  use Kegster.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

end
