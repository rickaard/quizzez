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
alias Quizzez.Quizzes.Question
alias Quizzez.Quizzes.Answer

##### USERS #####
user_1 =
  Repo.insert!(%User{
    email: "admin@example.com",
    name: "Admin",
    provider: "Google"
  })

user_2 =
  Repo.insert!(%User{
    email: "johndoe@example.com",
    name: "John Doe",
    provider: "Google"
  })

##### USERS #####

##### FIRST QUIZ #####
quiz =
  Repo.insert!(%Quiz{
    title: "Elixir Quiz",
    description: "A little quix about Elixir and Pheonix",
    user: user_1
  })

q_answer_1 =
  Repo.insert!(%Answer{
    text: "2020",
    is_correct: false
  })

q_answer_2 =
  Repo.insert!(%Answer{
    text: "2010",
    is_correct: false
  })

q_answer_3 =
  Repo.insert!(%Answer{
    text: "2000",
    is_correct: false
  })

q_answer_4 =
  Repo.insert!(%Answer{
    text: "2012",
    is_correct: true
  })

first_quiz_question_1 =
  Repo.insert!(%Question{
    text: "When did Elixir get created?",
    quiz: quiz,
    answers: [q_answer_1, q_answer_2, q_answer_3, q_answer_4]
  })

q2_anser_1 =
  Repo.insert!(%Answer{
    text: "Object Oriented Programming",
    is_correct: false
  })

q2_anser_2 =
  Repo.insert!(%Answer{
    text: "Functional Programming",
    is_correct: true
  })

first_quiz_question_2 =
  Repo.insert!(%Question{
    text: "What kind of programming model is Elixir using?",
    quiz: quiz,
    answers: [q2_anser_1, q2_anser_2]
  })

##### FIRST QUIZ #####
