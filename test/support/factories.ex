defmodule QuizzezWeb.Factories do
  @moduledoc """
  Factories for schemas to be used in tests
  """
  use ExMachina.Ecto, repo: Quizzez.Repo

  alias Quizzez.Accounts
  alias Quizzez.Quizzes

  def user_factory do
    %Accounts.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      provider: "google",
      name: "John Doe"
    }
  end

  def identity_user_factory do
    %Accounts.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      name: "John Doe",
      encrypted_password: "password"
    }
  end

  def quiz_factory do
    %Quizzes.Quiz{
      title: sequence(:title, &"Quiz-#{&1} title"),
      description: "Quiz description",
      category: "misc"
    }
  end

  def question_factory do
    %Quizzes.Question{
      text: sequence(:text, &"What is question #{&1}?")
    }
  end

  def answer_factory do
    %Quizzes.Answer{
      text: sequence(:text, &"This is answer #{&1}?")
    }
  end
end
