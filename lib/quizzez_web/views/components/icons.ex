defmodule QuizzezWeb.Components.Icons do
  @moduledoc false
  use Phoenix.Component

  def more_icon(assigns) do
    assigns = assign_new(assigns, :width, fn -> "24" end)
    assigns = assign_new(assigns, :height, fn -> "24" end)

    ~H"""
    <svg width={@width} height={@height} stroke-width="1.5" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M18 12.5C18.2761 12.5 18.5 12.2761 18.5 12C18.5 11.7239 18.2761 11.5 18 11.5C17.7239 11.5 17.5 11.7239 17.5 12C17.5 12.2761 17.7239 12.5 18 12.5Z" fill="currentColor" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
      <path d="M12 12.5C12.2761 12.5 12.5 12.2761 12.5 12C12.5 11.7239 12.2761 11.5 12 11.5C11.7239 11.5 11.5 11.7239 11.5 12C11.5 12.2761 11.7239 12.5 12 12.5Z" fill="currentColor" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
      <path d="M6 12.5C6.27614 12.5 6.5 12.2761 6.5 12C6.5 11.7239 6.27614 11.5 6 11.5C5.72386 11.5 5.5 11.7239 5.5 12C5.5 12.2761 5.72386 12.5 6 12.5Z" fill="currentColor" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
    </svg>
    """
  end
end
