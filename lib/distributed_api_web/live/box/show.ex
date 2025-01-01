defmodule DistributedApiWeb.BoxLive.Show do
  use DistributedApiWeb, :live_view

  alias DistributedApi.Boxes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    box = Boxes.get_box!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:box, box)
     |> assign(:items, Boxes.get_box_items(box))}
  end

  defp page_title(:show), do: "Show Box live"
  defp page_title(:edit), do: "Edit Box live"
end
