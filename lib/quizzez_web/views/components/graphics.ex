defmodule QuizzezWeb.Components.Graphics do
  @moduledoc """
  A component with graphics to be used, i.e charts
  """
  use Phoenix.Component

  def progress_circle(assigns) do
    assigns = assign_new(assigns, :width, fn -> 142 end)
    radius = assigns.width / 2 - 8
    graphic_center = assigns.width / 2

    IO.inspect(assigns, label: "assigns")
    IO.inspect(assigns.width, label: "assigns.width")

    ~H"""
    <div class="relative flex items-center justify-center">
      <svg class="relative" height={@width} width={@width}>
        <circle class="stroke-gray-400" cx={graphic_center} cy={graphic_center} r={radius - 6} stroke-width="18" fill="none" />
        <%= if @score >= 10 do %>
          <circle
            cx={@width / 2}
            cy={@width / 2}
            r={radius}
            stroke-linecap="round"
            stroke-width="12"
            fill="none"
            stroke-dasharray={"#{circle_dash_length(@score, radius)} 500"}
            style={"transform-origin: 50% 50%; transform: rotate(-90deg); stroke: #{circle_color(@score)}"}
          />
        <% end %>
      </svg>
      <div class="absolute text-5xl text-center p-0 m-0 flex justify-center items-baseline" style={"color: #{circle_color(@score)}"}>
        <span class={"text-6xl mr-1 font-bold"}><%= @score %></span>
        <span class="text-base">%</span>
      </div>
    </div>
    """
  end

  defp circle_dash_length(score, radius) do
    round(2 * :math.pi() * radius / 100 * score)
  end

  def circle_color(score) when score <= 50, do: "#881819"
  def circle_color(_score), do: "#9CFFFA"
end
