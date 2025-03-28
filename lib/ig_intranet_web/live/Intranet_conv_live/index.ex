defmodule IgIntranetWeb.IntranetConvLive.Index do
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

  defp apply_action(socket, :index, _params) do
    current_user_id = socket.assigns.current_user.id

    socket
    |> assign(:page_title, "Listing conversations")
    |> assign(:intranet_conversation, nil)
    |> assign(:users, Accounts.list_users())
    |> assign(
      :intranet_conversations,
      Chats.list_intranet_conversation_with_preload_user(current_user_id)
    )
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Intranet conversation")
    |> assign(:intranet_conversation, %IntranetConversation{
      intranet_messages: [%IntranetMessage{}]
    })
    |> assign(:intranet_message, nil)
    |> assign(:users, Accounts.list_users())
    |> assign(:intranet_conversations, Chats.list_intranet_conversation_with_preload_user(socket.assigns.current_user.id))
  end

end
