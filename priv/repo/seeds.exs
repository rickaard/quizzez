# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Quizzez.Repo.insert!(%Quizzez.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Quizzez.Repo

alias Quizzez.Accounts.User
alias Quizzez.Quizzes.Quiz

##### USERS #####
user_1 =
  Repo.insert!(%User{
    email: "admin@example.com",
    name: "Admin",
    provider: "Google"
  })

##### FIRST QUIZ #####
quiz_1_question_1 = %{
  text: "When did Elixir get created?",
  answers: [
    %{text: "2020", is_correct: false},
    %{text: "2010", is_correct: false},
    %{text: "2000", is_correct: false},
    %{text: "2012", is_correct: true}
  ]
}

quiz_1_question_2 = %{
  text: "What kind of programming model is Elixir using?",
  answers: [
    %{text: "Object Oriented Programming", is_correct: false},
    %{text: "Functional Programming", is_correct: true}
  ]
}

quiz_1_question_3 = %{
  text: "What kind of database is often used with Pheonix?",
  answers: [
    %{text: "PostgreSQL", is_correct: true},
    %{text: "MySQL", is_correct: false},
    %{text: "MongoDB", is_correct: false},
    %{text: "MSSQL", is_correct: false}
  ]
}

Repo.insert!(%Quiz{
  title: "Elixir Quiz",
  description: "A little quix about Elixir and Pheonix",
  questions: [
    quiz_1_question_1,
    quiz_1_question_2,
    quiz_1_question_3
  ],
  user: user_1
})
