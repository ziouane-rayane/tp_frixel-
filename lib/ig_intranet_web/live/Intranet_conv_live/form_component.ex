defmodule IgIntranetWeb.IntranetConvLive.FormComponent do
  use IgIntranetWeb, :live_component

  alias IgIntranet.Chats


  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage intranet_conversation records and associate users to the conversation.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="intranet_conversation-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:conversation_topic]} type="text" label="Conversation topic" />

        <.input
          field={@form[:conversation_type]}
          type="select"
          options={Ecto.Enum.values(IgIntranet.Chats.IntranetConversation, :conversation_type)}
          label="Conversation type"
        />

        <.input
          field={@form[:conversation_status]}
          type="select"
          options={Ecto.Enum.values(IgIntranet.Chats.IntranetConversation, :conversation_status)}
          label="Conversation status"
        />

        <.input
          field={@form[:user_ids]}
          type="select"
          options={@users}
          multiple={true}
          value={@users_in_conv}
          label="Select users"
        />

        <.inputs_for :let={ef} field={@form[:intranet_messages]}>
          <.input type="text" field={ef[:message_body]} placeholder="new message" />
          <.input field={ef[:user_id]} type="hidden" value={@current_user.id} />
        </.inputs_for>


        <:actions>
          <.button phx-disable-with="Saving...">Save Intranet conversation</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end


  @impl true
  def update(%{intranet_conversation: intranet_conversation} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Chats.change_intranet_conversation(intranet_conversation))
     end)}
  end

  @impl true
  def handle_event("validate", %{"intranet_conversation" => intranet_conversation_params}, socket) do
    changeset =
      Chats.change_intranet_conversation(
        socket.assigns.intranet_conversation,
        intranet_conversation_params
      )

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"intranet_conversation" => intranet_conversation_params}, socket) do
    save_intranet_conversation(socket, socket.assigns.action, intranet_conversation_params)
  end

  defp save_intranet_conversation(socket, :new, intranet_conversation_params) do
    case Chats.create_conversation_with_log(intranet_conversation_params, socket.assigns.current_user.email) do
      {:ok, intranet_conversation} ->
        notify_parent({:saved, intranet_conversation |> Chats.preload_intranet_messages()})

        {:noreply,
         socket
         |> put_flash(:info, "Intranet conversation created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_intranet_conversation(socket, :edit, intranet_conversation_params) do
    case Chats.update_intranet_conversation_with_user(
           socket.assigns.intranet_conversation,
           intranet_conversation_params
         ) do
      {:ok, intranet_conversation} ->
        notify_parent({:saved, intranet_conversation})

        {:noreply,
         socket
         |> put_flash(:info, "Intranet conversation updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end


  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
