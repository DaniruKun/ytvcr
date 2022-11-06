defmodule Ytvcr.CassettesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ytvcr.Cassettes` context.
  """

  @doc """
  Generate a cassette.
  """
  def cassette_fixture(attrs \\ %{}) do
    {:ok, cassette} =
      attrs
      |> Enum.into(%{})
      |> Ytvcr.Cassettes.create_cassette()

    cassette
  end
end
