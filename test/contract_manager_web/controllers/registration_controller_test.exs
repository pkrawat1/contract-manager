defmodule ContractManagerWeb.RegistrationControllerTest do
  @moduledoc false

  use ContractManagerWeb.ConnCase

  import ContractManagerWeb.Factory

  alias ContractManager.Accounts
  alias ContractManager.Accounts.User

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "User Registration" do
    setup do
      [
        valid_user_data: build(:user),
        invalid_user_data: build(:user, email: "", full_name: "", password: "")
      ]
    end

    @tag user: :valid
    test "create_registration/1 with valid data", context do
      %{valid_user_data: valid_user_data} = context
      params = Map.from_struct(valid_user_data)

      conn =
        post(
          build_conn,
          registration_path(build_conn, :create),
          registration: params
        )

      assert %{"jwt" => jwt, "user" => user} = json_response(conn, 201)

      assert user = %{
               "full_name" => valid_user_data.full_name,
               "email" => valid_user_data.email
             }
    end

    @tag user: :invalid
    test "create_registration/1 with invalid/existing data", context do
      params = %{email: "abcd", full_name: "", password: 123}
      conn = post(build_conn, registration_path(build_conn, :create), registration: params)

      assert %{
               "errors" => %{
                 "email" => ["has invalid format"],
                 "full_name" => ["can't be blank"],
                 "password" => ["is invalid"]
               }
             } = json_response(conn, 422)
    end
  end
end
