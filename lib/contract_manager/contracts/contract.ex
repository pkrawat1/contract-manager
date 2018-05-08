defmodule ContractManager.Contracts.Contract do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contracts" do
    field(:costs, :decimal)
    field(:ends_on, :date)
    field(:name, :string)

    belongs_to(:category, ContractManager.Contracts.Category)
    belongs_to(:vendor, ContractManager.Contracts.Vendor)

    timestamps()
  end

  @doc false
  def changeset(contract, attrs) do
    contract
    |> cast(attrs, [:name, :costs, :ends_on, :vendor_id, :category_id])
    |> validate_required([:name, :costs, :ends_on, :vendor_id, :category_id])
  end
end
