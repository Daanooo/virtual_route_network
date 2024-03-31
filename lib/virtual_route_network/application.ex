defmodule VirtualRouteNetwork.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      VirtualRouteNetworkWeb.Telemetry,
      VirtualRouteNetwork.Repo,
      {DNSCluster, query: Application.get_env(:virtual_route_network, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: VirtualRouteNetwork.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: VirtualRouteNetwork.Finch},
      # Start a worker by calling: VirtualRouteNetwork.Worker.start_link(arg)
      # {VirtualRouteNetwork.Worker, arg},
      # Start to serve requests, typically the last entry
      VirtualRouteNetworkWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VirtualRouteNetwork.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VirtualRouteNetworkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
