defmodule ContractManagerWeb.SessionController do
  use ContractManagerWeb, :controller

  alias ContractManager.Accounts
  alias ContractManagerWeb.Guardian
  alias Accounts.User

  action_fallback(ContractManagerWeb.FallbackController)

  def create(conn, %{"session" => session_params}) do
    with {:ok, %User{} = user} <- Accounts.create_session(session_params) do
      {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)

      conn
      |> put_status(:created)
      |> render("show.json", jwt: jwt, user: user)
    end
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> render("delete.json")
  end
end
