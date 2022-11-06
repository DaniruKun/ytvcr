defmodule Ytvcr.CassettesTest do
  use Ytvcr.DataCase

  alias Ytvcr.Cassettes

  describe "cassettes" do
    alias Ytvcr.Cassettes.Cassette

    import Ytvcr.CassettesFixtures

    @invalid_attrs %{}

    test "list_cassettes/0 returns all cassettes" do
      cassette = cassette_fixture()
      assert Cassettes.list_cassettes() == [cassette]
    end

    test "get_cassette!/1 returns the cassette with given id" do
      cassette = cassette_fixture()
      assert Cassettes.get_cassette!(cassette.id) == cassette
    end

    test "create_cassette/1 with valid data creates a cassette" do
      valid_attrs = %{}

      assert {:ok, %Cassette{} = cassette} = Cassettes.create_cassette(valid_attrs)
    end

    test "create_cassette/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cassettes.create_cassette(@invalid_attrs)
    end

    test "update_cassette/2 with valid data updates the cassette" do
      cassette = cassette_fixture()
      update_attrs = %{}

      assert {:ok, %Cassette{} = cassette} = Cassettes.update_cassette(cassette, update_attrs)
    end

    test "update_cassette/2 with invalid data returns error changeset" do
      cassette = cassette_fixture()
      assert {:error, %Ecto.Changeset{}} = Cassettes.update_cassette(cassette, @invalid_attrs)
      assert cassette == Cassettes.get_cassette!(cassette.id)
    end

    test "delete_cassette/1 deletes the cassette" do
      cassette = cassette_fixture()
      assert {:ok, %Cassette{}} = Cassettes.delete_cassette(cassette)
      assert_raise Ecto.NoResultsError, fn -> Cassettes.get_cassette!(cassette.id) end
    end

    test "change_cassette/1 returns a cassette changeset" do
      cassette = cassette_fixture()
      assert %Ecto.Changeset{} = Cassettes.change_cassette(cassette)
    end
  end
end
