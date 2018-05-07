defmodule ContractManagerWeb.CategoryControllerTest do
  use ContractManagerWeb.ConnCase

  alias ContractManager.Contracts
  alias ContractManager.Contracts.Category
  import ContractManagerWeb.Factory

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:category) do
    {:ok, category} = Contracts.create_category(@create_attrs)
    category
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
    test "lists all categories", %{conn: conn} do
      conn = get(conn, category_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create category" do
    test "renders category when data is valid", %{conn: conn, user: user} do
      conn = post(conn, category_path(conn, :create), category: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(sign_in(user), category_path(conn, :show, id))
      assert json_response(conn, 200)["data"] == %{"id" => id, "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, category_path(conn, :create), category: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update category" do
    setup [:create_category]

    test "renders category when data is valid", %{
      conn: conn,
      category: %Category{id: id} = category,
      user: user
    } do
      conn = put(conn, category_path(conn, :update, category), category: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(sign_in(user), category_path(conn, :show, id))
      assert json_response(conn, 200)["data"] == %{"id" => id, "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, category: category} do
      conn = put(conn, category_path(conn, :update, category), category: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete category" do
    setup [:create_category]

    test "deletes chosen category", %{conn: conn, category: category, user: user} do
      conn = delete(conn, category_path(conn, :delete, category))
      assert response(conn, 204)
    end
  end

  defp create_category(_) do
    category = fixture(:category)
    {:ok, category: category}
  end
end
