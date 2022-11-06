defmodule YtvcrWeb.CassetteLiveTest do
  use YtvcrWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ytvcr.CassettesFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_cassette(_) do
    cassette = cassette_fixture()
    %{cassette: cassette}
  end

  describe "Index" do
    setup [:create_cassette]

    test "lists all cassettes", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.cassette_index_path(conn, :index))

      assert html =~ "Listing Cassettes"
    end

    test "saves new cassette", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.cassette_index_path(conn, :index))

      assert index_live |> element("a", "New Cassette") |> render_click() =~
               "New Cassette"

      assert_patch(index_live, Routes.cassette_index_path(conn, :new))

      assert index_live
             |> form("#cassette-form", cassette: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cassette-form", cassette: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cassette_index_path(conn, :index))

      assert html =~ "Cassette created successfully"
    end

    test "updates cassette in listing", %{conn: conn, cassette: cassette} do
      {:ok, index_live, _html} = live(conn, Routes.cassette_index_path(conn, :index))

      assert index_live |> element("#cassette-#{cassette.id} a", "Edit") |> render_click() =~
               "Edit Cassette"

      assert_patch(index_live, Routes.cassette_index_path(conn, :edit, cassette))

      assert index_live
             |> form("#cassette-form", cassette: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cassette-form", cassette: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cassette_index_path(conn, :index))

      assert html =~ "Cassette updated successfully"
    end

    test "deletes cassette in listing", %{conn: conn, cassette: cassette} do
      {:ok, index_live, _html} = live(conn, Routes.cassette_index_path(conn, :index))

      assert index_live |> element("#cassette-#{cassette.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cassette-#{cassette.id}")
    end
  end

  describe "Show" do
    setup [:create_cassette]

    test "displays cassette", %{conn: conn, cassette: cassette} do
      {:ok, _show_live, html} = live(conn, Routes.cassette_show_path(conn, :show, cassette))

      assert html =~ "Show Cassette"
    end

    test "updates cassette within modal", %{conn: conn, cassette: cassette} do
      {:ok, show_live, _html} = live(conn, Routes.cassette_show_path(conn, :show, cassette))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cassette"

      assert_patch(show_live, Routes.cassette_show_path(conn, :edit, cassette))

      assert show_live
             |> form("#cassette-form", cassette: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#cassette-form", cassette: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cassette_show_path(conn, :show, cassette))

      assert html =~ "Cassette updated successfully"
    end
  end
end
