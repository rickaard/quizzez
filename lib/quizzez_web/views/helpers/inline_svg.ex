defmodule QuizzezWeb.SVGHelpers do
  @moduledoc """
  Helper function to inline SVG's in the view

  SVG's should be places in assets/static/svg
  and should be used in your templates like so:
  <%= SVGHelpers.inline_svg("name_on_svg_file") %>

  """
  def inline_svg(file_name) do
    path = static_path(file_name)

    case File.read(path) do
      {:ok, file} -> {:safe, file}
      {:error, _} -> raise "No SVG found at #{path}"
    end
  end

  defp static_path(file_name) do
    path = "assets/static/svg"
    [path, "#{file_name}.svg"] |> Path.join() |> Path.expand()
  end
end
