defmodule YtvcrWeb.CassetteLive.Index do
  use YtvcrWeb, :live_view

  alias Ytvcr.Cassettes
  alias Ytvcr.Cassettes.Cassette

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :cassettes, list_cassettes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cassette")
    |> assign(:cassette, Cassettes.get_cassette!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cassette")
    |> assign(:cassette, %Cassette{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cassettes")
    |> assign(:cassette, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cassette = Cassettes.get_cassette!(id)
    {:ok, _} = Cassettes.delete_cassette(cassette)

    {:noreply, assign(socket, :cassettes, list_cassettes())}
  end

  defp list_cassettes do
    Cassettes.list_cassettes()
  end
end
