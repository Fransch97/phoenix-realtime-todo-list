defmodule RealtimeTodoWeb.UserSocket do
  use Phoenix.Socket

  ## Canali
  channel "mouse:track", RealtimeTodoWeb.MouseChannel

  # Configurazione del WebSocket
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
