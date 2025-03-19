defmodule IgIntranetWeb.IntranetChatLive.Index do
  use IgIntranetWeb, :live_view

  alias IgIntranet.Chats
  alias IgIntranet.Chats.IntranetMessage

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Chats.subscribe()
     end
    {:ok, socket}
  end

  @impl true
  @spec handle_params(any(), any(), map()) :: {:noreply, map()}
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end



  @impl true
  def handle_info({:message_created, %{id: message_id}}, socket) do
    created_message = Chats.get_intranet_message_with_preload!(message_id)
    created_message |> IO.inspect(label: "lib/ig_intranet_web/live/intranet_chat_live/index.ex:26")
    socket =
      case (created_message.user_id != socket.assigns.current_user.id) do
       true ->
        socket |>  assign(:intranet_messages,[created_message | socket.assigns.intranet_messages])

       _ -> socket
    end
    {:noreply, socket}
  end

  def handle_info(_msg, socket) do
    {:noreply, socket}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Intranet messages")
    |> assign(:intranet_message, nil)
    |> assign(:intranet_messages, Chats.list_intranet_message_with_preload())
  end

  defp apply_action(socket, :new, _params) do
    intranet_conversations = Chats.list_intranet_conversation_with_preload()

    socket
    |> assign(:page_title, "New Intranet message")
    |> assign(:intranet_conversations, intranet_conversations)
    |> assign(:intranet_message, %IntranetMessage{})
  end



end
