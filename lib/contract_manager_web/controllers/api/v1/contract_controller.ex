defmodule ContractManagerWeb.ContractController do
  use ContractManagerWeb, :controller

  alias ContractManager.Contracts
  alias ContractManager.Contracts.Contract

  action_fallback(ContractManagerWeb.FallbackController)

  def index(conn, _params) do
    contracts = Contracts.list_contracts()
    render(conn, "index.json", contracts: contracts)
  end

  def create(conn, %{"contract" => contract_params}) do
    with {:ok, %Contract{} = contract} <- Contracts.create_contract(contract_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", contract_path(conn, :show, contract))
      |> render("show.json", contract: Contracts.get_contract!(contract.id))
    end
  end

  def show(conn, %{"id" => id}) do
    contract = Contracts.get_contract!(id)
    render(conn, "show.json", contract: contract)
  end

  def update(conn, %{"id" => id, "contract" => contract_params}) do
    contract = Contracts.get_contract!(id)

    with {:ok, %Contract{} = contract} <- Contracts.update_contract(contract, contract_params) do
      render(conn, "show.json", contract: contract)
    end
  end

  def delete(conn, %{"id" => id}) do
    contract = Contracts.get_contract!(id)

    with {:ok, %Contract{}} <- Contracts.delete_contract(contract) do
      send_resp(conn, :no_content, "")
    end
  end
end
