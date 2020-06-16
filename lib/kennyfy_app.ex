defmodule KennyfyApp do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: KennyfyApp.Controller, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: KennyfyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
