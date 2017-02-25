defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug Ueberauth

  alias Discuss.User

  def callback(%{assigns: %{ueberauth_auth: auth }} = conn, %{"provider" => provider}) do
    user_params = %{auth_token: auth.credentials.token, auth_provider: provider, email: auth.info.email,
      username: auth.info.nickname, image_url: auth.info.urls.avatar_url }
    changeset = User.changeset(%User{}, user_params)

    signin(conn, changeset)
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: topic_path(conn, :index))
  end

  defp signin(conn, changeset) do
    case User.upsert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome #{user.username}!")
        |> put_session(:user_id, user.id)
        |> redirect(to: topic_path(conn, :index))
      {:error, _msg} ->
        conn
        |> put_flash(:error, "Error Signing In")
        |> redirect(to: topic_path(conn, :index))
    end
  end
end

