defmodule QuizzezWeb.ProfileView do
  use QuizzezWeb, :view

  def quiz_plural_text(quiz_list) when length(quiz_list) == 1, do: "quiz"
  def quiz_plural_text(_quiz_list), do: "quizzes"
end
