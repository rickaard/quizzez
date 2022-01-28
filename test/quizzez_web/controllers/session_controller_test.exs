defmodule QuizzezWeb.SessionControllerTest do
  use QuizzezWeb.ConnCase

  describe "GET /" do
    test "renders login page", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))

      response = html_response(conn, 200)
      assert response =~ "Sign in"
      assert response =~ "Email address"
      assert response =~ "Password"
      assert response =~ "or sign in with"
      assert response =~ "Google"
    end

    test "redirects a user on successfull login", %{conn: conn} do
      encrypted_password = Argon2.hash_pwd_salt("password")

      user =
        insert(:identity_user,
          email: "johndoe@example.com",
          encrypted_password: encrypted_password
        )

      user_params = %{
        "email" => "johndoe@example.com",
        "password" => "password"
      }

      conn = post(conn, Routes.session_path(conn, :create), %{"user" => user_params})

      assert redirected_to(conn, 302) == Routes.profile_path(conn, :show, user.id)

      conn = get(recycle(conn), Routes.profile_path(conn, :show, user.id))

      response = html_response(conn, 200)
      assert response =~ "Hi John Doe, welcome to your profile"
    end

    test "shows error message on failed login", %{conn: conn} do
      encrypted_password = Argon2.hash_pwd_salt("password")

      insert(:identity_user,
        email: "johndoe@example.com",
        encrypted_password: encrypted_password
      )

      user_params = %{
        "email" => "johndoe@example.com",
        "password" => "anotherpassword"
      }

      conn = post(conn, Routes.session_path(conn, :create), %{"user" => user_params})

      response = html_response(conn, 200)
      assert response =~ "Incorrect email or password"
    end

    test "account created with google cannot use regular sign in", %{conn: conn} do
      insert(:user, email: "johndoe@example.com", provider: "google")

      user_params = %{
        "email" => "johndoe@example.com",
        "password" => "password"
      }

      conn = post(conn, Routes.session_path(conn, :create), %{"user" => user_params})

      response = html_response(conn, 200)
      assert response =~ "Your account was created with Google. Please use that login method."
    end
  end
end
