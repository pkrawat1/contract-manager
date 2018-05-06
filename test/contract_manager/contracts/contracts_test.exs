defmodule ContractManager.ContractsTest do
  use ContractManager.DataCase

  alias ContractManager.Contracts

  describe "vendors" do
    alias ContractManager.Contracts.Vendor

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def vendor_fixture(attrs \\ %{}) do
      {:ok, vendor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Contracts.create_vendor()

      vendor
    end

    test "list_vendors/0 returns all vendors" do
      vendor = vendor_fixture()
      assert Contracts.list_vendors() == [vendor]
    end

    test "get_vendor!/1 returns the vendor with given id" do
      vendor = vendor_fixture()
      assert Contracts.get_vendor!(vendor.id) == vendor
    end

    test "create_vendor/1 with valid data creates a vendor" do
      assert {:ok, %Vendor{} = vendor} = Contracts.create_vendor(@valid_attrs)
      assert vendor.name == "some name"
    end

    test "create_vendor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contracts.create_vendor(@invalid_attrs)
    end

    test "update_vendor/2 with valid data updates the vendor" do
      vendor = vendor_fixture()
      assert {:ok, vendor} = Contracts.update_vendor(vendor, @update_attrs)
      assert %Vendor{} = vendor
      assert vendor.name == "some updated name"
    end

    test "update_vendor/2 with invalid data returns error changeset" do
      vendor = vendor_fixture()
      assert {:error, %Ecto.Changeset{}} = Contracts.update_vendor(vendor, @invalid_attrs)
      assert vendor == Contracts.get_vendor!(vendor.id)
    end

    test "delete_vendor/1 deletes the vendor" do
      vendor = vendor_fixture()
      assert {:ok, %Vendor{}} = Contracts.delete_vendor(vendor)
      assert_raise Ecto.NoResultsError, fn -> Contracts.get_vendor!(vendor.id) end
    end

    test "change_vendor/1 returns a vendor changeset" do
      vendor = vendor_fixture()
      assert %Ecto.Changeset{} = Contracts.change_vendor(vendor)
    end
  end
end
