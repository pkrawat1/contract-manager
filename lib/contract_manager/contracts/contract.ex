defmodule ContractManager.Contracts.Contract do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "contracts" do
    field(:costs, :decimal)
    field(:ends_on, :date)

    belongs_to(:category, ContractManager.Contracts.Category)
    belongs_to(:vendor, ContractManager.Contracts.Vendor)
    belongs_to(:user, ContractManager.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(contract, attrs) do
    contract
    |> cast(attrs, [:costs, :ends_on, :vendor_id, :category_id, :user_id])
    |> validate_required([:costs, :ends_on, :vendor_id, :category_id, :user_id])
    |> validate_ends_on
  end

  def with_vendor_and_category(query \\ __MODULE__) do
    from(q in query, preload: [:vendor, :category])
  end

  def for_user(query, user_id),
    do: from(q in query, where: q.user_id == ^user_id, preload: [:vendor, :category])

  def list_with_asc_ends_on(query \\ __MODULE__) do
    from(
      ct in query,
      where: ct.ends_on >= ^Date.utc_today(),
      order_by: [asc: :ends_on]
    )
  end

  defp validate_ends_on(changeset) do
    ends_on = get_field(changeset, :ends_on)

    if ends_on && Date.compare(ends_on, Date.utc_today()) == :lt do
      add_error(changeset, :ends_on, "must be in future")
    else
      changeset
    end
  end
end
