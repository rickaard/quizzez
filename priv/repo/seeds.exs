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
