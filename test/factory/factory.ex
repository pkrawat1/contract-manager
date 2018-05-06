defmodule ContractManagerWeb.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: ContractManager.Repo

  use ContractManagerWeb.{UserFactory}
end
