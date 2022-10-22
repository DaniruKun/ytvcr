defmodule Ytvcr.Ytarchive do
  @moduledoc """
  Wrapper around the `ytarchive` CLI tool.
  """

  require Logger

  @doc """
  Wrapper around calling `ytarchive`, can be passed arguments as a list.
  Returns a tuple containing a `Port` opened with `ytarchive`.

  Usage example:
  ```elixir
  Ytarchive.execute ["https://www.youtube.com/watch?v=swe6ea_9P2s", "best"]
  ```
  """
  @spec execute(list(String.t())) :: {:error, :ytarchive_not_found} | {:ok, port()}
  def execute(args \\ ["-V"]) when length(args) > 0 do
    if (path = ytarchive_path()) && verify_ffmpeg() do
      opts = [:binary, {:args, args}, :exit_status]
      port = Port.open({:spawn_executable, path}, opts)
      {:ok, port}
    else
      {:error, :ytarchive_not_found}
    end
  end

  defp ytarchive_path do
    case Application.get_env(:ytvcr, :ytarchive_path, nil) do
      nil -> System.find_executable("ytarchive")
      path -> path
    end
  end

  defp verify_ffmpeg, do: System.find_executable("ffmpeg")
end
