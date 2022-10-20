defmodule Ytvcr.Repo.Migrations.CreateRecordings do
  use Ecto.Migration

  def change do
    create table(:recordings, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :state, :string, default: "scheduled", null: false
      add :external_video_id, :string, null: false
      add :external_site_name, :string, null: false
      add :temp_file_path, :string, null: false
      add :download_url, :string

      timestamps()
    end
  end
end
