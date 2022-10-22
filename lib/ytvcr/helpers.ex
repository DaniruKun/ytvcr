defmodule Ytvcr.Helpers do
  @moduledoc """
  Various helpers.
  """

  @doc """
  Gracefully stop the OS process connected to the given Erlang `port`.
  """
  @spec stop_port_process(port()) :: {any, non_neg_integer}
  def stop_port_process(port) do
    port
    |> Port.info()
    |> Keyword.get(:os_pid)
    |> then(fn pid -> System.cmd("kill", ["-s", "SIGINT", to_string(pid)]) end)
  end
end
