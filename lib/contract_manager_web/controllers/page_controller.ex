defmodule ContractManagerWeb.PageController do
  use ContractManagerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
