defmodule ContractManagerWeb.SessionControllerTest do
  @moduledoc false

  use ContractManagerWeb.ConnCase

  import ContractManagerWeb.Factory

  alias ContractManager.Accounts
  alias ContractManager.Accounts.User

  setup %{conn: conn} do
    user = insert(:user)

    {:ok, conn: sign_in(user), user: user}
  end

  defp sign_in(user) do
    conn =
      post(
        build_conn,
        session_path(build_conn, :create),
        session: %{email: user.email, password: user.password}
      )

    %{"jwt" => jwt, "user" => user} = json_response(conn, 201)
    put_req_header(build_conn, "authorization", "Bearer: " <> jwt)
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

    @tag user: :invalid
    test "create_session/1 with invalid data" do
      conn =
        post(
          build_conn,
          session_path(build_conn, :create),
          session: %{email: "", password: ""}
        )

      assert %{"error" => "Invalid email or password"} = json_response(conn, 422)
    end

    @tag user: :valid
    test "delete with invalid data", context do
      %{user: user} = context
      conn = sign_in(user)

      conn = delete(conn, session_path(conn, :delete))

      assert %{"ok" => true} = json_response(conn, 200)
    end
  end
end
