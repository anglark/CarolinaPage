defmodule CarolinaPage.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CarolinaPageWeb.Telemetry,
      CarolinaPage.Repo,
      {DNSCluster, query: Application.get_env(:carolina_page, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CarolinaPage.PubSub},
      # Start a worker by calling: CarolinaPage.Worker.start_link(arg)
      # {CarolinaPage.Worker, arg},
      # Start to serve requests, typically the last entry
      CarolinaPageWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CarolinaPage.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CarolinaPageWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
