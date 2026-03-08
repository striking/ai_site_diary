defmodule SiteReport.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SiteReportWeb.Telemetry,
      SiteReport.Repo,
      {DNSCluster, query: Application.get_env(:site_report, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SiteReport.PubSub},
      # Start a worker by calling: SiteReport.Worker.start_link(arg)
      # {SiteReport.Worker, arg},
      # Start to serve requests, typically the last entry
      SiteReportWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SiteReport.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SiteReportWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
