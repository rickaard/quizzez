defmodule QuizzezWeb.Components.Blobs do
  @moduledoc false
  use Phoenix.Component

  def purple(assigns) do
    ~H"""
      <svg viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="100%" id="blobSvg">
        <path id="blob" d="M439,339Q392,428,294,457.5Q196,487,137,410Q78,333,85,253.5Q92,174,144.5,96.5Q197,19,279,65Q361,111,423.5,180.5Q486,250,439,339Z" fill="#635994"></path>
      </svg>
    """
  end

  def blue(assigns) do
    ~H"""
      <svg viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="100%" id="blobSvg">
        <path id="blob" d="M423.5,313.5Q351,377,275,425.5Q199,474,119,413Q39,352,34.5,248Q30,144,120,109.5Q210,75,289,88.5Q368,102,432,176Q496,250,423.5,313.5Z" fill="#5492ed"></path>
      </svg>
    """
  end

  def pink(assigns) do
    ~H"""
      <svg viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="100%" id="blobSvg">
        <path id="blob" d="M422.5,313Q351,376,275.5,422Q200,468,141.5,399Q83,330,77.5,247Q72,164,143,128.5Q214,93,284,106.5Q354,120,424,185Q494,250,422.5,313Z" fill="#eb506e"></path>
      </svg>
    """
  end

  def light_blue(assigns) do
    ~H"""
      <svg viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="100%" id="blobSvg">
        <path id="blob" d="M410.5,318Q358,386,285.5,398Q213,410,121,383Q29,356,56.5,263Q84,170,140,91Q196,12,271,71Q346,130,404.5,190Q463,250,410.5,318Z" fill="#b1cefc"></path>
      </svg>
    """
  end

  def ligh_grey(assigns) do
    ~H"""
    <svg viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="100%" id="blobSvg">
      <path id="blob" d="M410.5,318Q358,386,285.5,398Q213,410,121,383Q29,356,56.5,263Q84,170,140,91Q196,12,271,71Q346,130,404.5,190Q463,250,410.5,318Z" fill="#eff0f0"></path>
    </svg>
    """
  end
end
