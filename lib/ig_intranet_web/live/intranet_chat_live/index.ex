defmodule IgIntranetWeb.IntranetChatLive.Index do
  use IgIntranetWeb, :live_view

  alias IgIntranet.Chats
  alias IgIntranet.Chats.IntranetMessage
  alias IgIntranet.Accounts
  alias IgIntranet.Chats.IntranetConversation

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

    socket =
      case created_message.user_id != socket.assigns.current_user.id do
        true ->
          socket
          |> assign(:intranet_messages, [created_message | socket.assigns.intranet_messages])

        _ ->
          socket
      end

    {:noreply, socket}
  end

  def handle_info(_msg, socket) do
    {:noreply, socket}
  end

  defp apply_action(socket, :index, _params) do
    current_user_id = socket.assigns.current_user.id

    socket
    |> assign(:page_title, "Listing Intranet messages")
    |> assign(:intranet_message, nil)
    |> assign(:users, Accounts.list_users())
    |> assign(:intranet_conversations, Chats.list_intranet_conversations())
    |> assign(:changeset, Chats.change_intranet_message(%IntranetMessage{}))
    |> assign(
      :intranet_messages,
      Chats.list_intranet_message_with_preload_current_user(current_user_id)
    )
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Intranet message")
    |> assign(:intranet_conversation, %IntranetConversation{
      intranet_messages: [%IntranetMessage{}]
    })
    |> assign(:intranet_message, nil)
    |> assign(:users, Accounts.list_users())
    |> assign(
      :intranet_messages,
      Chats.list_intranet_message_with_preload_current_user(socket.assigns.current_user.id)
    )
  end

  @impl true
  def handle_event("send_message", %{
        "message_body" => message_body,
        "recipient_id" => recipient_id,
        "intranet_conversation_id" => intranet_conversation_id
      }, socket) do

      {:ok, message} = Chats.create_intranet_message(%{
      message_body: message_body,
      user_id: socket.assigns.current_user.id,
      recipient_id: recipient_id,
      intranet_conversation_id: intranet_conversation_id
    })

    {:noreply, assign(socket, :intranet_messages, [message | socket.assigns.intranet_messages])}
  end



  @impl true
  def handle_event(_event, _unsigned_params, socket) do
    {:noreply, socket}
  end

end
