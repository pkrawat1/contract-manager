defmodule ContractManagerWeb.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: ContractManagerWeb.Repo

  use ContractManagerWeb.{UserFactory}
end
