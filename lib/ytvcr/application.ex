defmodule Ytvcr.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Ytvcr.Repo,
      # Start the Telemetry supervisor
      YtvcrWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ytvcr.PubSub},
      # Start the Endpoint (http/https)
      YtvcrWeb.Endpoint,
      # Start a worker by calling: Ytvcr.Worker.start_link(arg)
      # {Ytvcr.Worker, arg}
      {Oban, Application.fetch_env!(:ytvcr, Oban)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ytvcr.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    YtvcrWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
