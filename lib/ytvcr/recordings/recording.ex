defmodule Ytvcr.Recordings.Recording do
  @moduledoc """
  `Recording`s can have different states, starting with `scheduled` and ending with `uploaded`.
  Once a `Recording` has been `uploaded`, the local file can and should be deleted to free space for other scheduled temporary fragment files required by `ytarchive`.

  The next state should be calcu
  """
  use Ecto.Schema
  import Ecto.Changeset

  @valid_states ~w(scheduled recording finished uploaded)
  @valid_external_sites ~w(youtube)

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "recordings" do
    field :state, :string, default: "scheduled"
    field :external_video_id
    field :external_site_name
    field :temp_file_path
    field :download_url

    timestamps()
  end

  def create_changeset(recording, attrs) do
    creation_attrs = ~w(external_video_id external_site_name temp_file_path)a

    recording
    |> cast(attrs, creation_attrs)
    |> validate_required(creation_attrs)
    |> validate_inclusion(:external_site_name, @valid_external_sites)
  end

  @doc false
  def changeset(recording, attrs) do
    recording
    |> cast(attrs, [
      :state,
      :external_video_id,
      :external_site_name,
      :temp_file_path,
      :download_url
    ])
    |> validate_required([:state, :external_video_id, :external_site_name, :temp_file_path])
    |> validate_inclusion(:state, @valid_states)
    |> validate_inclusion(:external_site_name, @valid_external_sites)
  end

  defp next_state(prev_state) do
    case prev_state do
      nil -> "scheduled"
      "scheduled" -> "recording"
      "recording" -> "finished"
      "finished" -> "uploaded"
      "uploaded" -> nil
    end
  end
end
