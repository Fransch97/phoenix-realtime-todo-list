defmodule RealtimeTodo.Repo do
  use Ecto.Repo,
    otp_app: :realtime_todo,
    adapter: Ecto.Adapters.Postgres
end
