defmodule ContractManager.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :vendor_id, references(:vendors, on_delete: :nothing)

      timestamps()
    end

    create index(:categories, [:vendor_id])
  end
end
