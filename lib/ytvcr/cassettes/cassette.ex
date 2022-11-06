defmodule Ytvcr.Cassettes.Cassette do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "cassettes" do
    field :name
    belongs_to :recording, Ytvcr.Recordings.Recording
    belongs_to :user, Ytvcr.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(cassette, attrs) do
    cassette
    |> cast(attrs, [])
    |> validate_required([])
  end
end
