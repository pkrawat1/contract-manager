defmodule ContractManagerWeb.SessionController do
  use ContractManagerWeb, :controller

  alias ContractManager.Accounts
  alias ContractManagerWeb.Guardian

  def create(conn, %{"session" => session_params}) do
    case Accounts.create_session(session_params) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)

        conn
        |> put_status(:created)
        |> render("show.json", jwt: jwt, user: user)

      :error ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json")
    end
  end

  def delete(conn, _) do
  end
end
