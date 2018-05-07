defmodule ContractManagerWeb.ContractControllerTest do
  use ContractManagerWeb.ConnCase

  alias ContractManager.Contracts
  alias ContractManager.Contracts.Contract
  import ContractManagerWeb.Factory

  @create_attrs %{costs: "120.5", ends_on: ~D[2010-04-17], name: "some name"}
  @update_attrs %{costs: "456.7", ends_on: ~D[2011-05-18], name: "some updated name"}
  @invalid_attrs %{costs: nil, ends_on: nil, name: nil}

  def fixture(:contract) do
    {:ok, contract} = Contracts.create_contract(@create_attrs)
    contract
  end

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

  describe "index" do
    test "lists all contracts", %{conn: conn} do
      conn = get(conn, contract_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create contract" do
    test "renders contract when data is valid", %{conn: conn, user: user} do
      conn = post(conn, contract_path(conn, :create), contract: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(sign_in(user), contract_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "costs" => "120.5",
               "ends_on" => "2010-04-17",
               "name" => "some name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, contract_path(conn, :create), contract: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update contract" do
    setup [:create_contract]

    test "renders contract when data is valid", %{
      conn: conn,
      contract: %Contract{id: id} = contract,
      user: user
    } do
      conn = put(conn, contract_path(conn, :update, contract), contract: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(sign_in(user), contract_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "costs" => "456.7",
               "ends_on" => "2011-05-18",
               "name" => "some updated name"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, contract: contract} do
      conn = put(conn, contract_path(conn, :update, contract), contract: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete contract" do
    setup [:create_contract]

    test "deletes chosen contract", %{conn: conn, contract: contract} do
      conn = delete(conn, contract_path(conn, :delete, contract))
      assert response(conn, 204)
    end
  end

  defp create_contract(_) do
    contract = fixture(:contract)
    {:ok, contract: contract}
  end
end
