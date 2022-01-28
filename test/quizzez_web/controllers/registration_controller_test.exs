defmodule QuizzezWeb.RegistrationControllerTest do
  use QuizzezWeb.ConnCase

  alias Quizzez.Accounts.User
  alias Quizzez.Repo

  describe "GET /" do
    test "renders registration page", %{conn: conn} do
      conn = get(conn, Routes.registration_path(conn, :new))

      response = html_response(conn, 200)
      assert response =~ "Registration"
      assert response =~ "Email address"
      assert response =~ "Your name"
      assert response =~ "Password"
      assert response =~ "Password Confirmation"
      assert response =~ "type=\"submit\">Register</button>"
      assert response =~ "or create account with"
    end

    test "redirects already logged in users", %{conn: conn} do
      user = insert(:user)

      conn =
        conn
        |> log_in_user(user)
        |> get(Routes.registration_path(conn, :new))

      assert redirected_to(conn, 302) == Routes.profile_path(conn, :show, user.id)

      conn = get(recycle(conn), Routes.profile_path(conn, :show, user.id))
      assert html_response(conn, 200) =~ "You are already logged in.."
    end
  end

  describe "POST /create" do
    test "saves and logs a user in", %{conn: conn} do
      user_params = %{
        "email" => "johndoe@example.com",
        "name" => "John Doe",
        "password" => "password",
        "password_confirmation" => "password"
      }

      conn = post(conn, Routes.registration_path(conn, :create), %{"user" => user_params})

      assert %User{email: "johndoe@example.com"} = user = Repo.all(User) |> List.first()
      assert redirected_to(conn, 302) == Routes.profile_path(conn, :show, user.id)

      conn = get(recycle(conn), Routes.profile_path(conn, :show, user.id))

      response = html_response(conn, 200)
      assert response =~ "Hi John Doe, welcome to your profile"
      assert response =~ "Logout"
    end

    test "does not allow to create new account with existing email", %{conn: conn} do
      insert(:user, email: "johndoe@example.com")

      user_params = %{
        "email" => "johndoe@example.com",
        "name" => "John Doe",
        "password" => "password",
        "password_confirmation" => "password"
      }

      conn = post(conn, Routes.registration_path(conn, :create), %{"user" => user_params})

      response = html_response(conn, 200)
      assert 1 = Repo.all(User) |> Enum.count()
      assert response =~ "has already been taken"
    end

    test "`password_confirmation` must match password to create new account", %{conn: conn} do
      user_params = %{
        "email" => "johndoe@example.com",
        "name" => "John Doe",
        "password" => "password",
        "password_confirmation" => "anotherpassword"
      }

      conn = post(conn, Routes.registration_path(conn, :create), %{"user" => user_params})

      assert 0 = Repo.all(User) |> Enum.count()
      response = html_response(conn, 200)
      assert response =~ "does not match password"
    end
  end
end
