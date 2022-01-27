defmodule Quizzez.AccountsTest do
  use Quizzez.DataCase

  alias Quizzez.Accounts
  alias Quizzez.Accounts.User
  alias Quizzez.Quizzes

  describe "users" do
    @invalid_attrs %{email: nil, name: nil, provider: nil}

    test "list_users/0 returns all users" do
      user = insert(:user)
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)
      assert Accounts.get_user!(user.id) == user
    end

    test "register/1 with valid data creates a user" do
      valid_attrs = %{
        email: "some email",
        name: "some name",
        password: "supersecretpassword",
        password_confirmation: "supersecretpassword"
      }

      assert {:ok, %User{} = user} = Accounts.register(valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
    end

    test "register/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.register(@invalid_attrs)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:user)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "update_user/2 with valida data updates a user" do
      user = insert(:user)

      # assert {:ok, _user} = Accounts.update_user(user, %{name: "Updated name"})
      assert {:ok, %User{} = user} = Accounts.update_user(user, %{name: "Updated name"})
      assert user.name == "Updated name"
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "deleting a user also deletes created quizzes by that user" do
      user = insert(:user)
      quiz = insert(:quiz, user: user)
      assert {:ok, %User{}} = Accounts.delete_user(user)

      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
      assert_raise Ecto.NoResultsError, fn -> Quizzes.get_quiz!(quiz.id) end
    end

    test "get_by_email/1 returns the user with given email" do
      user = insert(:user)

      assert ^user = Accounts.get_by_email(user.email)
    end

    test "get_by_email/1 returns nil if no user is found with given email" do
      insert(:user, email: "person@example.com")

      refute nil = Accounts.get_by_email("another_person@example.com")
    end
  end
end
