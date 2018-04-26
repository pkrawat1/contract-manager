defmodule ContractManagerWeb.RegistrationController do
  use ContractManagerWeb, :controller

  alias ContractManager.Accounts
  alias ContractManager.Accounts.User

  action_fallback ContractManagerWeb.FallbackController

  def create(conn, %{"registration" => registration_params}) do
  end
end
