defmodule QuizzezWeb.CategoryController do
  use QuizzezWeb, :controller

  def index(conn, _params) do
    categories = ~w[food geography history math misc music programming science workout]

    render(conn, "index.html", categories: categories)
  end
end
