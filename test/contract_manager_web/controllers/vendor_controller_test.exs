defmodule ContractManagerWeb.VendorControllerTest do
  use ContractManagerWeb.ConnCase

  alias ContractManager.Contracts
  alias ContractManager.Contracts.Vendor

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:vendor) do
    {:ok, vendor} = Contracts.create_vendor(@create_attrs)
    vendor
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all vendors", %{conn: conn} do
      conn = get(conn, vendor_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create vendor" do
    test "renders vendor when data is valid", %{conn: conn} do
      conn = post(conn, vendor_path(conn, :create), vendor: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, vendor_path(conn, :show, id))
      assert json_response(conn, 200)["data"] == %{"id" => id, "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, vendor_path(conn, :create), vendor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update vendor" do
    setup [:create_vendor]

    test "renders vendor when data is valid", %{conn: conn, vendor: %Vendor{id: id} = vendor} do
      conn = put(conn, vendor_path(conn, :update, vendor), vendor: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, vendor_path(conn, :show, id))
      assert json_response(conn, 200)["data"] == %{"id" => id, "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, vendor: vendor} do
      conn = put(conn, vendor_path(conn, :update, vendor), vendor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete vendor" do
    setup [:create_vendor]

    test "deletes chosen vendor", %{conn: conn, vendor: vendor} do
      conn = delete(conn, vendor_path(conn, :delete, vendor))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, vendor_path(conn, :show, vendor))
      end)
    end
  end

  defp create_vendor(_) do
    vendor = fixture(:vendor)
    {:ok, vendor: vendor}
  end
end
