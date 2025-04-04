defmodule IgIntranet.Chats.IntranetMessage do
  @moduledoc """
    Intranet_messages représente les messages de l'intranet.
    Un message fait partie d'une conversation sous la forme: intranet_messages belongs_to intranet_conversation
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias IgIntranet.Chats.IntranetConversation
  alias IgIntranet.Accounts.User

  schema "intranet_messages" do
    field :message_body, :string

    belongs_to(:intranet_conversation, IntranetConversation)
    belongs_to(:user, User)

    embeds_one :meta_data, MetaData, on_replace: :update do
      field :url, :string
      field :mentions, {:array, :string}
    end

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(intranet_message, attrs) do
    intranet_message
    |> cast(attrs, [:message_body, :intranet_conversation_id, :user_id])
    |> validate_required([:message_body, :intranet_conversation_id, :user_id])
    |> cast_embed(:meta_data, required: false, with: &meta_data_changeset/2)
  end

  def changeset_with_conversation(intranet_message, attrs) do
    intranet_message
    |> cast(attrs, [:message_body, :intranet_conversation_id, :user_id])
    |> cast_embed(:meta_data, required: false, with: &meta_data_changeset/2)
    |> validate_required([:message_body, :user_id])
  end

  defp meta_data_changeset(%IgIntranet.Chats.IntranetMessage.MetaData{} = meta_data, attrs) do
    meta_data
    |> cast(attrs, [:url, :mentions])
  end
end
