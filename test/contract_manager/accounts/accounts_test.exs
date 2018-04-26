defmodule ContractManager.AccountsTest do
  use ContractManager.DataCase

  alias ContractManager.Accounts

  describe "Accounts" do
    alias ContractManager.Accounts.User

    @valid_attrs %{email: "pankaj@test.com", password: "some encrypted_password", full_name: "some full_name"}
    @update_attrs %{email: "some updated email", password: "some updated encrypted_password", full_name: "some updated full_name"}
    @invalid_attrs %{email: nil, password: nil, full_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "create_registration/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_registration(@valid_attrs)
      assert user.email == "pankaj@test.com"
      assert user.encrypted_password != "some encrypted_password"
      assert user.full_name == "some full_name"
    end

    test "create_registration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_registration(@invalid_attrs)
    end
  end
end
