defmodule Mix.Tasks.Credo.Sync.Config do
  @moduledoc """
  Synchronizes the Credo configuration file from a URL.

  You can use this task to download a file from a URL and save it as .credo.exs
  in the root of this project, eg.:

      mix credo.sync.config https://github.com/rrrene/credo/raw/master/.credo.exs

  *Note: Atm, the supported protocols are http:// and https://.*

  When you already have synchronized a Credo configuration with this task, then
  simply to update it just run:

      mix credo.sync.config

  In this case the existing .credo.exs file contains a comment with the URL,
  which will be used to re-download the file and update it.
  """

  use Mix.Task

  alias CredoSyncConfig.CLI

  @shortdoc "Synchronize the Credo configuration from a URL."

  def run([]) do
    CLI.get_config_path()
    |> CLI.sync_from_existing_config()
    |> print()
  end

  def run([url | _]) do
    CLI.get_config_path()
    |> CLI.sync_from_url(url)
    |> print()
  end

  defp print({:ok, {path, url}}), do:
    IO.puts("Successfully sync'ed config #{path} from URL #{url}")
  defp print({:error, {:missing_url, path}}), do:
    IO.puts("The config #{path} does not contain any information for the URL")
  defp print({:error, {:read_failed, path, :enoent}}), do:
    IO.puts("The config #{path} does not exist")
  defp print({:error, {:read_failed, path, reason}}), do:
    IO.puts("Failed to read config #{path} because #{inspect(reason)}")
  defp print({:error, {:unsupported_url, url}}), do:
    IO.puts("The URL #{url} is not supported. Please use http:// or https://")
  defp print({:error, {:download_failed, url, reason}}), do:
    IO.puts("Failed to download config from #{url} because #{inspect(reason)}")
  defp print({:error, {:save_failed, path, reason}}), do:
    IO.puts("Failed to save config #{path} because #{inspect(reason)}")
  defp print({:error, reason}), do:
    IO.puts("Failed to sync config because #{inspect(reason)}")

end
