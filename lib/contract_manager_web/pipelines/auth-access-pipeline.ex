defmodule ContractManagerWeb.AuthAccessPipeline do
  @moduledoc """
  Custom pipeline for guardian
  """
  use Guardian.Plug.Pipeline, otp_app: :contract_manager

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
