defmodule Discuss.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Router.Helpers

  def init(_params) do
  end

  def call(conn, _init_params) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_flash(:error, "You Must be Logged In")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt()
    end
  end
end

