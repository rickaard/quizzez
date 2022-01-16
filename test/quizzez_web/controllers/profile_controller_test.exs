defmodule QuizzezWeb.ProfileControllerTest do
  use QuizzezWeb.ConnCase

  describe "GET :show" do
    test "GET /", %{conn: conn} do
      conn = conn |> get(Routes.profile_path(conn, :show, 1))
      assert html_response(conn, 200) =~ "welcome to your profile"
    end
  end
end
