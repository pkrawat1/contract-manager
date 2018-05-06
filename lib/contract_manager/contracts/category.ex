defmodule ContractManager.Contracts.Category do
  use Ecto.Schema
  import Ecto.Changeset


  schema "categories" do
    field :name, :string
    field :vendor_id, :id

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
