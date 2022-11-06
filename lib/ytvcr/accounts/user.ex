defmodule Ytvcr.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username
    field :email

    has_many :cassettes, Ytvcr.Cassettes.Cassette

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [])
    |> validate_required([])
  end
end
