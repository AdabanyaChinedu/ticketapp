defmodule TicketappWeb.PageController do
  use TicketappWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
