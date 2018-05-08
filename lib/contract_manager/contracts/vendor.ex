defmodule ContractManager.Contracts.Vendor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vendors" do
    field(:name, :string)

    has_many(:categories, ContractManager.Contracts.Category)

    timestamps()
  end

  @doc false
  def changeset(vendor, attrs) do
    vendor
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
