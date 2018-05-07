defmodule ContractManagerWeb.Router do
  use ContractManagerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :api_auth do
    plug(ContractManagerWeb.AuthAccessPipeline)
  end

  # Other scopes may use custom stacks.
  scope "/api", ContractManagerWeb do
    pipe_through(:api)

    scope "/v1" do
      post("/registrations", RegistrationController, :create)
      post("/sessions", SessionController, :create)
    end
  end

  scope "/api", ContractManagerWeb do
    pipe_through(:api_auth)

    scope "/v1" do
      delete("/sessions", SessionController, :delete)
      resources("/vendors", VendorController)
      resources("/categories", CategoryController)
      resources("/contracts", ContractController)
    end
  end

  scope "/", ContractManagerWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/*main", MainController, :index)
  end
end
