defmodule QuizzezWeb.ChangeQuizComponent do
  import QuizzezWeb.ErrorHelpers

  # use Phoenix.LiveComponent
  use QuizzezWeb, :live_view
  use Phoenix.HTML

  alias Quizzez.Repo
  alias Quizzez.Accounts.User
  alias Quizzez.Quizzes.Quiz
  alias Quizzez.Quizzes.Question
  alias Quizzez.Quizzes.Answer
  alias Quizzez.Quizzes

  def mount(_params, %{"user_id" => user_id} = _session, socket) do
    socket =
      socket
      |> assign(:changeset, empty_full_quiz())
      |> assign(:user_id, user_id)

    {:ok, socket}
  end

  def handle_event("validate", %{"quiz" => quiz_params}, socket) do
    changeset =
      %Quiz{}
      |> Quizzes.change_quiz(quiz_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"quiz" => quiz} = _params, socket) do
    user = %User{} = Repo.get(User, socket.assigns.user_id)

    changeset =
      user
      |> Ecto.build_assoc(:quizzes)
      |> Quiz.changeset(quiz)

    case Repo.insert(changeset) do
      {:ok, %Quiz{}} ->
        socket =
          socket
          |> assign(:changeset, empty_full_quiz())
          |> put_flash(:info, "Quiz saved 👍")
          |> redirect(to: Routes.page_path(socket, :index))

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("add_question", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("add_answer", _params, socket) do
    # quiz = Map.from_struct(socket.assigns.changeset.data)

    # changeset =
    #   quiz
    #   |> Map.update!(:questions, fn question ->
    #     question
    #     |> Enum.map(&transform_to_map(&1))
    #   end)

    # IO.inspect(changeset, label: "changeset")

    {:noreply, socket}
  end

  def handle_event("remove_question", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("remove_answer", _params, socket) do
    {:noreply, socket}
  end

  defp empty_full_quiz do
    Quizzes.change_quiz(%Quiz{
      questions: [
        %Question{
          answers: [
            %Answer{},
            %Answer{},
            %Answer{},
            %Answer{}
          ]
        }
      ]
    })
  end

  defp transform_to_map(%{__struct__: _} = struct), do: Map.from_struct(struct)
  defp transform_to_map(map) when is_map(map), do: map
  defp transform_to_map(other), do: other
end
