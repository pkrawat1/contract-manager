defmodule ContractManagerWeb.ContractView do
  use ContractManagerWeb, :view
  alias ContractManagerWeb.ContractView

  def render("index.json", %{contracts: contracts}) do
    %{data: render_many(contracts, ContractView, "contract.json")}
  end

  def render("show.json", %{contract: contract}) do
    %{data: render_one(contract, ContractView, "contract.json")}
  end

  def render("contract.json", %{contract: contract}) do
    %{id: contract.id,
      costs: contract.costs,
      ends_on: contract.ends_on,
      vendor: contract.vendor.name,
      category: contract.category.name,
      vendor_id: contract.vendor.id,
      category_id: contract.category.id
    }
  end
end
