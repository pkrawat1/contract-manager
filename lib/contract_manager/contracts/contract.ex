defmodule ContractManager.Contracts.Contract do
  use Ecto.Schema
  import Ecto.Changeset


  schema "contracts" do
    field :costs, :decimal
    field :ends_on, :date
    field :name, :string
    field :vendor_id, :id
    field :category_id, :id

    timestamps()
  end

  @doc false
  def changeset(contract, attrs) do
    contract
    |> cast(attrs, [:name, :costs, :ends_on])
    |> validate_required([:name, :costs, :ends_on])
  end
end
