defmodule ContractManagerWeb.UserFactory do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      alias ContractManager.Accounts.User

      def user_factory do
        %User{
          full_name: sequence(:full_name, &"Full Name #{&1}"),
          email: sequence(:email, &"foo-#{&1}@bar.com"),
          password: "12345678",
          encrypted_password: Comeonin.Argon2.hashpwsalt("12345678")
        }
      end
    end
  end
end
