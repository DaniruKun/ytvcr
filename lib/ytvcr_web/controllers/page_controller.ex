defmodule YtvcrWeb.PageController do
  use YtvcrWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
