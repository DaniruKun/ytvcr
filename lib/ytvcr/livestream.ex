defmodule Ytvcr.Livestream do
  @moduledoc """
  Functions related to external livestreams and their metadata.
  """

  require Logger

  @type video_id :: String.t()
  @type site_name :: String.t()

  @doc """
  Lookup the scheduled start for a given stream on a specific platform.
  At the moment only `youtube` is supported as an `external_site_name`, as well as only Holodex-indexed videos.
  Returns a `DateTime` converted to UTC.
  """
  @spec get_scheduled_start(video_id(), site_name()) ::
          {:ok, DateTime.t()} | {:error, Exception.t()}
  def get_scheduled_start(external_video_id, external_site_name \\ "youtube") do
    if external_site_name == "youtube" do
      with {:ok, video} <- Holodex.Api.Videos.video_info(external_video_id),
           {:ok, datetime, 0} <-
             video
             |> Map.get(:start_scheduled)
             |> DateTime.from_iso8601() do
        {:ok, datetime}
      else
        _ ->
          {:error, :failed_to_get_schedule}
      end
    else
      {:error, :unknown_site_name}
    end
  end

  @doc """
  Start recording an external video with the given params to `file_path` (without the extension).
  """
  @spec record(
          external_video_id :: String.t(),
          external_site_name :: String.t(),
          file_path :: String.t()
        ) :: :ignore | {:error, any} | {:ok, pid}
  def record(external_video_id, external_site_name, file_path) do
    with url <- build_external_url(external_video_id, external_site_name),
         args = [
           "-o",
           file_path,
           "--wait",
           "--thumbnail",
           "--merge",
           url,
           "best"
         ] do
      Logger.info("Starting recording of video with id: [#{external_video_id}]")
      Ytvcr.YtarchiveAdapter.start_link(args)
    end
  end

  defp build_external_url(video_id, site_name) do
    case site_name do
      "youtube" -> "https://youtu.be/#{video_id}"
      _ -> raise "unknown site: #{site_name}"
    end
  end
end
