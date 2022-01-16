defmodule QuizzezWeb.Factories do
  use ExMachina.Ecto, repo: Quizzez.Repo

  alias Quizzez.Accounts

  def user_factory do
    %Accounts.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      provider: "google",
      name: "John Doe"
    }
  end
end
