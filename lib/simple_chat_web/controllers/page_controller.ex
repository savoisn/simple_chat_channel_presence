defmodule SimpleChatWeb.PageController do
  use SimpleChatWeb, :controller

  alias SimpleChat.Chat.User

  def index(conn, _params) do
    changeset = SimpleChat.Chat.change_user(%User{})
    user = Plug.Conn.get_session(conn, :user)
    render(conn, "index.html", %{user: user, changeset: changeset, val: "Coucou"})
  end

  def disconnect_user(conn, _params) do
    Plug.Conn.delete_session(conn, :user)
    changeset = SimpleChat.Chat.change_user(%User{})
    render(conn, "index.html", %{user: nil, changeset: changeset, val: "Coucou"})
  end

  def define_user(conn, %{"user" => %{"text" => user}} = params) do
    changeset = SimpleChat.Chat.change_user(%User{})

    case user do
      "" ->
        conn
        |> put_flash(:error, "Username cannot be empty")
        |> render("index.html", %{user: nil, changeset: changeset, val: "Coucou"})

      _ ->
        conn
        |> Plug.Conn.put_session(:user, user)
        |> render("index.html", %{user: user, changeset: changeset, val: "Coucou"})
    end
  end
end
