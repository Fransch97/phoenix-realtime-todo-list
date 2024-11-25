defmodule RealtimeTodo.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Configura PubSub per il tuo progetto
      {Phoenix.PubSub, name: RealtimeTodo.PubSub},
      # Avvia il repo Ecto per l'accesso al database
      RealtimeTodo.Repo,
      # Avvia Telemetry per metriche
      RealtimeTodoWeb.Telemetry,
      # Avvia l'endpoint per gestire le richieste HTTP
      RealtimeTodoWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: RealtimeTodo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    RealtimeTodoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
