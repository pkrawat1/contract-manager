defmodule ContractManager.Contracts.Category do
  use Ecto.Schema
  import Ecto.Changeset


  schema "categories" do
    field :name, :string
    belongs_to :vendor, ContractManager.Contracts.Vendor

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :vendor_id])
    |> validate_required([:name, :vendor_id])
  end
end
