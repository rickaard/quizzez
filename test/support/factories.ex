defmodule QuizzezWeb.Factories do
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

  def quiz_factory do
    %Quizzes.Quiz{
      title: sequence(:title, &"Quiz-#{&1} title"),
      description: "Quiz description"
    }
  end

  def question_factory do
    %Quizzes.Question{
      text: sequence(:text, &"What is question #{&1}?"),
      quiz: build(:quiz)
    }
  end

  def category_factory do
    %Quizzes.Category{
      name: sequence(:name, &"Category #{&1}")
    }
  end
end
