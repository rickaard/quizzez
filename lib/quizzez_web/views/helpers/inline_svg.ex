defmodule QuizzezWeb.SVGHelpers do
  def inline_svg(file_name) do
    path = static_path(file_name)
    case File.read(path) do
      {:ok, file} -> {:safe, file}
      {:error, _} -> raise "No SVG found at #{path}"
    end
  end

  defp static_path(file_name) do
    path = "assets/static/svg"
    [path, "#{file_name}.svg"] |> Path.join() |> Path.expand
  end
end
