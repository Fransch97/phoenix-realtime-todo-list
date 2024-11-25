defmodule RealtimeTodoWeb.MouseChannel do
  use Phoenix.Channel

  # Quando un client si unisce al canale
  def join("mouse:track", _message, socket) do
    {:ok, socket}
  end

  # Gestisci gli eventi "mouse_move" ricevuti dal client
  def handle_in("mouse_move", %{"x" => x, "y" => y}, socket) do
    # Invia la posizione a tutti gli altri client
    broadcast(socket, "mouse_update", %{"x" => x, "y" => y})
    {:noreply, socket}
  end
end
