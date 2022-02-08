defmodule QuizzezWeb.Components.QuizDetailCard do
  @moduledoc """
  A card component to be used to show details about a Quiz
  """
  use Phoenix.Component
  alias QuizzezWeb.Router.Helpers, as: Routes

  def card(assigns) do
    assigns = assign_new(assigns, :can_modify, fn -> false end)

    ~H"""
    <article class="group hover:cursor-pointer hover:border-gray-400 flex flex-row border border-solid border-x-gray-200 w-full h-full relative rounded-lg">

      <aside class="absolute w-full -top-2">
        <p class="bg-primary-50 text-white px-2 text-sm text-center w-max mx-auto"><%= @quiz.category %></p>
      </aside>

      <%= if @can_modify do %>
        <aside class="absolute -top-3 -right-3 border border-solid border-gray-300 rounded-full bg-white shadow-sm cursor-pointer hover:bg-gray-300">
          <i class="">
            <QuizzezWeb.Components.Icons.more_icon />
          </i>
        </aside>
      <% end %>

      <div class="h-full py-2 px-2">
        <div class="h-full min-w-[130px] flex items-center bg-primary bg-opacity-10 rounded-lg overflow-hidden">
          <img class="group-hover:scale-125 transition" src={Routes.static_path(QuizzezWeb.Endpoint, quiz_illustration_path(@quiz.category))} alt=""/>
        </div>
      </div>

      <article class="flex flex-col p-2">
        <header class="flex flex-row justify-between mt-2">
          <h6 class="font-bold text-primary"><%= @quiz.title %></h6>
        </header>

        <p class="h-[120px] flex-grow text-ellipsis overflow-hidden"><%= @quiz.description %></p>
        <footer class="mt-2 text-sm text-gray-500">
          <p><%= questions_text(@quiz.questions) %> </p>
        </footer>
      </article>

    </article>
    """
  end

  defp quiz_illustration_path("programming"), do: "/images/quiz/programming.svg"
  defp quiz_illustration_path("misc"), do: "/images/quiz/misc.svg"
  defp quiz_illustration_path("food"), do: "/images/quiz/food.svg"
  defp quiz_illustration_path("geography"), do: "/images/quiz/geography.svg"
  defp quiz_illustration_path("history"), do: "/images/quiz/history.svg"
  defp quiz_illustration_path("math"), do: "/images/quiz/math.svg"
  defp quiz_illustration_path("music"), do: "/images/quiz/music.svg"
  defp quiz_illustration_path("workout"), do: "/images/quiz/workout.svg"
  defp quiz_illustration_path("science"), do: "/images/quiz/science.svg"

  defp questions_text(question_list) when length(question_list) > 1 do
    "#{length(question_list)} questions"
  end

  defp questions_text(question_list) when question_list == [] do
    "0 questions"
  end

  defp questions_text(question_list), do: "#{length(question_list)} question"
end
