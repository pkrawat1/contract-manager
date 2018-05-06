defmodule ContractManagerWeb.VendorController do
  use ContractManagerWeb, :controller

  alias ContractManager.Contracts
  alias ContractManager.Contracts.Vendor

  action_fallback(ContractManagerWeb.FallbackController)

  def index(conn, _params) do
    vendors = Contracts.list_vendors()
    render(conn, "index.json", vendors: vendors)
  end

  def create(conn, %{"vendor" => vendor_params}) do
    with {:ok, %Vendor{} = vendor} <- Contracts.create_vendor(vendor_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", vendor_path(conn, :show, vendor))
      |> render("show.json", vendor: vendor)
    end
  end

  def show(conn, %{"id" => id}) do
    vendor = Contracts.get_vendor!(id)
    render(conn, "show.json", vendor: vendor)
  end

  def update(conn, %{"id" => id, "vendor" => vendor_params}) do
    vendor = Contracts.get_vendor!(id)

    with {:ok, %Vendor{} = vendor} <- Contracts.update_vendor(vendor, vendor_params) do
      render(conn, "show.json", vendor: vendor)
    end
  end

  def delete(conn, %{"id" => id}) do
    vendor = Contracts.get_vendor!(id)

    with {:ok, %Vendor{}} <- Contracts.delete_vendor(vendor) do
      send_resp(conn, :no_content, "")
    end
  end
end
