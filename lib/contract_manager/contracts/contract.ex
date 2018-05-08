defmodule ContractManager.Contracts.Contract do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contracts" do
    field(:costs, :decimal)
    field(:ends_on, :date)

    belongs_to(:category, ContractManager.Contracts.Category)
    belongs_to(:vendor, ContractManager.Contracts.Vendor)

    timestamps()
  end

  @doc false
  def changeset(contract, attrs) do
    contract
    |> cast(attrs, [:costs, :ends_on, :vendor_id, :category_id])
    |> validate_required([:costs, :ends_on, :vendor_id, :category_id])
    |> validate_ends_on
  end

  defp validate_ends_on(changeset) do
    ends_on = get_field(changeset, :ends_on)

    if ends_on && Date.compare(ends_on, Date.utc_today) == :lt do
      add_error(changeset, :ends_on, "must be in future")
    else
      changeset
    end
  end
end
