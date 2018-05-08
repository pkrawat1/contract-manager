defmodule ContractManagerWeb.VendorView do
  use ContractManagerWeb, :view
  alias ContractManagerWeb.VendorView

  def render("index.json", %{vendors: vendors}) do
    %{data: render_many(vendors, VendorView, "vendor.json")}
  end

  def render("show.json", %{vendor: vendor}) do
    %{data: render_one(vendor, VendorView, "vendor.json")}
  end

  def render("vendor.json", %{vendor: vendor}) do
    %{
      id: vendor.id,
      name: vendor.name,
      categories: render_many(vendor.categories, ContractManagerWeb.CategoryView, "category.json")
    }
  end
end
