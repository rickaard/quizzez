defmodule QuizzezWeb.Components.CategoryCard do
  @moduledoc """
  A card component to be used to show a category card

  """
  use Phoenix.Component
  alias QuizzezWeb.Router.Helpers, as: Routes

  def card(assigns) do
    ~H"""
      <article class="group flex flex-col w-full lg:w-[31%] h-full relative rounded-lg">
        <%= Phoenix.HTML.Link.link to: Routes.category_path(QuizzezWeb.Endpoint, :show, @category), class: "hover:cursor-pointer" do %>
          <div class="h-full min-w-[130px] max-h-[200px] flex items-center bg-primary bg-opacity-80 rounded-lg overflow-hidden">
            <img class="group-hover:scale-125 transition" src={Routes.static_path(QuizzezWeb.Endpoint, quiz_illustration_path(@category))} alt=""/>
          </div>
        <% end %>
        <h3 class="text-center font-bold"><%= String.upcase(@category) %></h3>
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
end
