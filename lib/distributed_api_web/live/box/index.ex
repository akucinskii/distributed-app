defmodule DistributedApiWeb.BoxLive.Index do
  use DistributedApiWeb, :live_view

  alias DistributedApi.Boxes
  alias DistributedApi.Boxes.Box

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :boxes, Boxes.list_boxes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Box live")
    |> assign(:box, Boxes.get_box!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Box live")
    |> assign(:box, %Box{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Boxes live")
    |> assign(:box, nil)
  end

  @impl true
  def handle_info({DistributedApiWeb.BoxLive.FormComponent, {:saved, box}}, socket) do
    {:noreply, stream_insert(socket, :boxes, box)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    box = Boxes.get_box!(id)
    {:ok, _} = Boxes.delete_box(box)

    {:noreply, stream_delete(socket, :boxes, box)}
  end
end
