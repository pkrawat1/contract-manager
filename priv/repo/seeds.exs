# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ContractManager.Repo.insert!(%ContractManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ContractManager.Contracts
alias ContractManager.Accounts
alias ContractManager.Repo

{:ok, user} = Accounts.create_registration(%{
  full_name: "Test",
  email: "test@123.com",
  password: "123456",
  password_confirmation: "123456"
})

vendors =
  %{
    "Vodafone" => ["Internet", "DSL", "Phone", "Mobile Phone"],
    "O2" => ["Internet", "DSL"],
    "Vattenfall" => ["Electricity", "Gas"],
    "McFit" => ["Gym"],
    "Sky" => ["Paid TV"]
  }
  |> Enum.map(fn {k, v} ->
    {:ok, vendor} = Contracts.create_vendor(%{name: k})
    Enum.map(v, &Contracts.create_category(%{name: &1, vendor_id: vendor.id}))
    vendor |> Repo.preload(:categories)
  end)

vendor = List.first(vendors)
category = List.first(vendor.categories)

Contracts.create_contract(%{
  name: "O2 Internet",
  ends_on: ~D[2019-04-17],
  vendor_id: vendor.id,
  category_id: category.id,
  user_id: user.id,
  costs: 10.5
})
