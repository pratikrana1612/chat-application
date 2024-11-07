defmodule Practice.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PracticeWeb.Telemetry,
      Practice.Repo,
      {DNSCluster, query: Application.get_env(:practice, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Practice.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Practice.Finch},
      # Start a worker by calling: Practice.Worker.start_link(arg)
      # {Practice.Worker, arg},
      # Start to serve requests, typically the last entry
      PracticeWeb.Endpoint,
      Pow.Store.Backend.MnesiaCache
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Practice.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PracticeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
