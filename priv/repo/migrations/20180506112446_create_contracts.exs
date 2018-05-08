defmodule ContractManager.Repo.Migrations.CreateContracts do
  use Ecto.Migration

  def change do
    create table(:contracts) do
      add :costs, :decimal
      add :ends_on, :date
      add :vendor_id, references(:vendors, on_delete: :nothing)
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:contracts, [:vendor_id])
    create index(:contracts, [:category_id])
  end
end
