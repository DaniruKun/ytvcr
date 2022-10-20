defmodule Ytvcr.RecordingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ytvcr.Recordings` context.
  """

  @doc """
  Generate a recording.
  """
  def recording_fixture(attrs \\ %{}) do
    {:ok, recording} =
      attrs
      |> Enum.into(%{
        external_video_id: video_id(),
        external_site_name: "youtube",
        temp_file_path: Faker.File.file_name(:video)
      })
      |> Ytvcr.Recordings.create_recording()

    recording
  end

  defp video_id(), do: Faker.String.base64(11)
end
