defmodule ContractManagerWeb.RegistrationControllerTest do
  @moduledoc false

  use ContractManagerWeb.ConnCase

  alias ContractManager.Accounts
  alias ContractManager.Accounts.User

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end
end
