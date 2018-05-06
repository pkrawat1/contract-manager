defmodule ContractManagerWeb.SessionControllerTest do
  @moduledoc false

  use ContractManagerWeb.ConnCase

  import ContractManagerWeb.Factory

  alias ContractManager.Accounts
  alias ContractManager.Accounts.User

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "User sessions" do
    setup do: [user: insert(:user)]

    @tag user: :valid
    test "create_session/1 with valid data", context do
      %{user: user} = context

      conn =
        post(
          build_conn,
          session_path(build_conn, :create),
          session: %{email: user.email, password: user.password}
        )

      assert %{"jwt" => jwt, "user" => user} = json_response(conn, 201)

      assert user = %{
               "full_name" => user["full_name"],
               "email" => user["email"]
             }
    end
  end
end
