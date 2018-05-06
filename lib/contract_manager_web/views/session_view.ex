defmodule ContractManagerWeb.SessionView do
  use ContractManagerWeb, :view

  def render("show.json", %{jwt: jwt, user: user}) do
    %{
      jwt: jwt,
      user: %{
        full_name: user.full_name,
        email: user.email
      }
    }
  end

  def render("error.json", _) do
    %{error: "Invalid email or password"}
  end

  def render("delete.json", _) do
    %{ok: true}
  end

  def render("forbidden.json", %{error: error}) do
    %{error: error}
  end
end