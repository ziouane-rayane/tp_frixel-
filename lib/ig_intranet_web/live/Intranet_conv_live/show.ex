defmodule IgIntranetWeb.IntranetConvLive.Show do
  use IgIntranetWeb, :live_view

  alias IgIntranet.Chats
  alias IgIntranet.Chats.IntranetMessage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(
      :intranet_messages,
      Chats.list_messages_conversation(id)
    )
     |> assign(:changeset, Chats.change_intranet_message(%IntranetMessage{}))
     |> assign(:intranet_conversation, Chats.get_intranet_conversation!(id))}

  end


  @impl true
  def handle_event("send_message", %{
        "message_body" => message_body,
        "user_id" => user_id,
        "intranet_conversation_id" => intranet_conversation_id
      }, socket) do

      {:ok, message} = Chats.create_intranet_message(%{
      message_body: message_body,
      user_id: user_id,
      intranet_conversation_id: intranet_conversation_id
    })

    {:noreply, assign(socket, :intranet_messages, [message | socket.assigns.intranet_messages])}
  end

  defp page_title(:show), do: "Show Intranet conversation"
end
