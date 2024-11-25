defmodule RealtimeTodoWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :realtime_todo

  @session_options [
    store: :cookie,
    key: "_realtime_todo_key",
    signing_salt: "tcRF4cZm",
    same_site: "Lax"
  ]

  # Aggiungi il socket per Phoenix Channels
  socket "/socket", RealtimeTodoWeb.UserSocket

  # Socket per LiveView
  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  plug Plug.Static,
    at: "/",
    from: :realtime_todo,
    gzip: false,
    only: RealtimeTodoWeb.static_paths()

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :realtime_todo
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug RealtimeTodoWeb.Router
end
