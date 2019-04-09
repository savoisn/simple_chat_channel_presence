defmodule SimpleChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      SimpleChat.Repo,
      # Start the endpoint when the application starts
      SimpleChatWeb.Endpoint,
      SimpleChatWeb.Presence
      # Starts a worker by calling: SimpleChat.Worker.start_link(arg)
      # {SimpleChat.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SimpleChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
