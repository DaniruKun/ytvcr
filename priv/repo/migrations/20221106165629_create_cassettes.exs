defmodule Ytvcr.Repo.Migrations.CreateCassettes do
  use Ecto.Migration

  def change do
    create table(:cassettes, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :name, :string, null: false
      add :user_id, references(:users)
      add :recording_id, references(:recordings, type: :uuid)

      timestamps()
    end
  end
end
