defmodule ContractManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :full_name, :string
      add :email, :string
      add :encrypted_password, :string

      timestamps()
    end

  end
end
