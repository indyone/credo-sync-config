defmodule CredoSyncConfig.Mixfile do
  use Mix.Project

  def project do
    [
      app: :credo_sync_config,
      version: "0.1.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false}
    ]
  end
end
