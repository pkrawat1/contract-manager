defmodule ContractManager.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias ContractManager.Repo

  alias ContractManager.Accounts.User

  def get_user(id) do
    Repo.get!(User, id)
  end

  @doc """
  Creates a registration.

  ## Examples

      iex> create_registration(%{field: value})
      {:ok, %User{}}

      iex> create_registration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_registration(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a session.

  ## Examples

      iex> create_session(%{"email" => email, "password" => password})
      {:ok, %User{}}

      iex> create_session(%{field: bad_value})
      :error

  """
  def create_session(%{"email" => email, "password" => password}) do
    user = Repo.get_by(User, email: String.downcase(email))

    case check_password(user, password) do
      true -> {:ok, user}
      _ -> {:error, :invalid_creds}
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> Comeonin.Argon2.dummy_checkpw()
      _ -> Comeonin.Argon2.checkpw(password, user.encrypted_password)
    end
  end
end
