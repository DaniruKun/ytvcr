defmodule YtvcrWeb.CassetteLive.FormComponent do
  use YtvcrWeb, :live_component

  alias Ytvcr.Cassettes

  @impl true
  def update(%{cassette: cassette} = assigns, socket) do
    changeset = Cassettes.change_cassette(cassette)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"cassette" => cassette_params}, socket) do
    changeset =
      socket.assigns.cassette
      |> Cassettes.change_cassette(cassette_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"cassette" => cassette_params}, socket) do
    save_cassette(socket, socket.assigns.action, cassette_params)
  end

  defp save_cassette(socket, :edit, cassette_params) do
    case Cassettes.update_cassette(socket.assigns.cassette, cassette_params) do
      {:ok, _cassette} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cassette updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_cassette(socket, :new, cassette_params) do
    case Cassettes.create_cassette(cassette_params) do
      {:ok, _cassette} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cassette created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
