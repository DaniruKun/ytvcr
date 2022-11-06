defmodule Ytvcr.Cassettes do
  @moduledoc """
  The Cassettes context.
  """

  import Ecto.Query, warn: false
  alias Ytvcr.Repo

  alias Ytvcr.Cassettes.Cassette

  @doc """
  Returns the list of cassettes.

  ## Examples

      iex> list_cassettes()
      [%Cassette{}, ...]

  """
  def list_cassettes do
    Repo.all(Cassette)
  end

  @doc """
  Gets a single cassette.

  Raises `Ecto.NoResultsError` if the Cassette does not exist.

  ## Examples

      iex> get_cassette!(123)
      %Cassette{}

      iex> get_cassette!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cassette!(id), do: Repo.get!(Cassette, id)

  @doc """
  Creates a cassette.

  ## Examples

      iex> create_cassette(%{field: value})
      {:ok, %Cassette{}}

      iex> create_cassette(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cassette(attrs \\ %{}) do
    %Cassette{}
    |> Cassette.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cassette.

  ## Examples

      iex> update_cassette(cassette, %{field: new_value})
      {:ok, %Cassette{}}

      iex> update_cassette(cassette, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cassette(%Cassette{} = cassette, attrs) do
    cassette
    |> Cassette.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cassette.

  ## Examples

      iex> delete_cassette(cassette)
      {:ok, %Cassette{}}

      iex> delete_cassette(cassette)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cassette(%Cassette{} = cassette) do
    Repo.delete(cassette)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cassette changes.

  ## Examples

      iex> change_cassette(cassette)
      %Ecto.Changeset{data: %Cassette{}}

  """
  def change_cassette(%Cassette{} = cassette, attrs \\ %{}) do
    Cassette.changeset(cassette, attrs)
  end
end
