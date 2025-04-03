defmodule IgIntranetWeb.LogLive.Show do
  use IgIntranetWeb, :live_view

  alias IgIntranet.ApplicationActivity

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:log, ApplicationActivity.get_log!(id))}
  end

  defp page_title(:show), do: "Show Log"
  defp page_title(:edit), do: "Edit Log"
end
