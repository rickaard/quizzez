defmodule QuizzezWeb.PageController do
  use QuizzezWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
