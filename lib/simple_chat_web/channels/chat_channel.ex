defmodule SimpleChatWeb.ChatChannel do
  use SimpleChatWeb, :channel
  alias SimpleChatWeb.Presence

  def join("chat:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    push(socket, "presence_state", Presence.list(socket))

    IO.puts("BISOUNOURS")
    IO.puts(socket.assigns.user_name)

    {:ok, _} =
      Presence.track(socket, socket.assigns.user_name, %{
        online_at: inspect(System.system_time(:second))
      })

    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat:lobby).
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  def handle_in("message", payload, socket) do
    broadcast(socket, "new_message", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
