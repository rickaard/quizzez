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
    encrypted_password: Argon2.hash_pwd_salt("password")
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

quiz_1_question_4 = %{
  text: "What programming language is Elixir built upon?",
  answers: [
    %{text: "Ruby", is_correct: false},
    %{text: "JavaScript", is_correct: false},
    %{text: "Erlang", is_correct: true},
    %{text: "C++", is_correct: false}
  ]
}

quiz_1_question_5 = %{
  text: "Who is the creator of Elixir?",
  answers: [
    %{text: "José Valim", is_correct: true},
    %{text: "Brendan Eich", is_correct: false},
    %{text: "Graydon Hoare", is_correct: false},
    %{text: "Anders Hejlsberg", is_correct: false}
  ]
}

Repo.insert!(%Quiz{
  title: "Elixir Quiz",
  description: "A little quix about Elixir and Pheonix",
  category: "misc",
  questions: [
    quiz_1_question_1,
    quiz_1_question_2,
    quiz_1_question_3,
    quiz_1_question_4,
    quiz_1_question_5
  ],
  user: user_1
})

quiz_2_question_1 = %{
  text: "What is 10 x 10?",
  answers: [
    %{text: "100", is_correct: true},
    %{text: "10", is_correct: false},
    %{text: "1000", is_correct: false},
    %{text: "1 000 000", is_correct: false}
  ]
}

quiz_2_question_2 = %{
  text: "What is 5 x 5?",
  answers: [
    %{text: "25", is_correct: true},
    %{text: "30", is_correct: false},
    %{text: "10", is_correct: false},
    %{text: "35", is_correct: false}
  ]
}

quiz_2_question_3 = %{
  text: "What is 3 x 3?",
  answers: [
    %{text: "6", is_correct: false},
    %{text: "12", is_correct: false},
    %{text: "9", is_correct: true},
    %{text: "27", is_correct: false}
  ]
}

quiz_2_question_4 = %{
  text: "What is 1337 + 1337?",
  answers: [
    %{text: "2674", is_correct: true},
    %{text: "2746", is_correct: false},
    %{text: "1787569", is_correct: false},
    %{text: "0", is_correct: false}
  ]
}

quiz_2_question_5 = %{
  text: "What is 12 / 3?",
  answers: [
    %{text: "36", is_correct: false},
    %{text: "4", is_correct: true},
    %{text: "15", is_correct: false},
    %{text: "3", is_correct: false}
  ]
}

Repo.insert!(%Quiz{
  title: "Math quiz",
  description: "A small and simple math quiz suited for children",
  category: "math",
  questions: [],
  user: user_1
})
