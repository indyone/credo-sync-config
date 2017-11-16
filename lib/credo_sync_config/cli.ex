defmodule CredoSyncConfig.CLI do
  @moduledoc """
  Contains functions for syncing a Credo configuration file.
  """

  @doc """
  Returns the .credo.exs path for this project.
  """
  def get_config_path(filename \\ ".credo.exs"), do: Path.join([File.cwd!(), filename])

  @doc """
  Downloads from a new URL, a .credo.exs file and saves it in the local project.
  """
  def sync_from_url(config_path, url) do
    with \
      {:ok, content} <- download(url),
      :ok <-  save_file(config_path, content, url: url)
    do
      {:ok, {config_path, url}}
    else
      e -> e
    end
  end

  @doc """
  Updates an existing .credo.exs (created by this task previously).
  """
  def sync_from_existing_config(config_path) do
    with \
      {:ok, url} <- extract_url(config_path),
      result <- sync_from_url(url, config_path)
    do
      result
    else
      e -> e
    end
  end

  defp download("http" <> _ = url) do
    :inets.start()
    :ssl.start()
    case :httpc.request(to_charlist(url)) do
      {:ok, {{_, 200, _}, _, body}} -> {:ok, to_string(body)}
      {:ok, {reason, _, _}} -> {:error, {:download_failed, url, reason}}
      {:error, reason} -> {:error, {:download_failed, url, reason}}
    end
  end
  defp download(url), do: {:error, {:unsupported_url, url}}

  defp save_file(config_path, content, options) do
    content = "# Url: #{options[:url]}\n" <> content
    case File.write(config_path, content) do
      :ok -> :ok
      {:error, reason} -> {:error, {:save_failed, config_path, reason}}
    end
  end

  defp extract_url(config_path) do
    with \
      {:ok, content} <- File.read(config_path),
      [_ | [url | _]] <- Regex.run(~r/^# Url: (.+)/, content)
    do
      {:ok, url}
    else
      [] -> {:error, {:missing_url, config_path}}
      {:error, reason} -> {:error, {:read_failed, config_path, reason}}
    end
  end

end
