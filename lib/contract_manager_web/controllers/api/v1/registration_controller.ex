defmodule ContractManagerWeb.RegistrationController do
  use ContractManagerWeb, :controller

  alias ContractManager.Accounts
  alias ContractManager.Accounts.User
  alias ContractManagerWeb.Guardian

  plug(:scrub_params, "registration" when action in [:create])

  action_fallback(ContractManagerWeb.FallbackController)

  def create(conn, %{"registration" => registration_params}) do
    with {:ok, user} <- Accounts.create_registration(registration_params) do
      {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)

      conn
      |> put_status(:created)
      |> render(ContractManagerWeb.SessionView, "show.json", jwt: jwt, user: user)
    end
  end
end
