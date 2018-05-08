defmodule ContractManagerWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ContractManagerWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(ContractManagerWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(ContractManagerWeb.ErrorView, :"404")
  end

  def call(conn, {:error, invalid_creds}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(ContractManagerWeb.SessionView, "error.json")
  end
end
