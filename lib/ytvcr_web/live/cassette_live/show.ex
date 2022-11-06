defmodule YtvcrWeb.CassetteLive.Show do
  use YtvcrWeb, :live_view

  alias Ytvcr.Cassettes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cassette, Cassettes.get_cassette!(id))}
  end

  defp page_title(:show), do: "Show Cassette"
  defp page_title(:edit), do: "Edit Cassette"
end
