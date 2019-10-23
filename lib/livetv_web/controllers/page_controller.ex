defmodule LivetvWeb.PageController do
  use LivetvWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
