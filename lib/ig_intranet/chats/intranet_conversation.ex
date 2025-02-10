defmodule IgIntranet.Chats.IntranetConversation do
  @moduledoc """
    Intranet_conversations représente les conversations de l'intranet.
    Une conversation a plusieurs types, publique ou privée.
    Une conversation a plusieurs statuts, actives ou archivées.
    Une conversation contient plusieurs messages, ils sont rattachés par la relation suivante: intranet_conversation has_many intranet_messages.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "intranet_conversations" do
    field :conversation_type, Ecto.Enum, values: [:public, :private]
    field :conversation_status, Ecto.Enum, values: [:active, :archived]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(intranet_conversation, attrs) do
    intranet_conversation
    |> cast(attrs, [:conversation_type, :conversation_status])
    |> validate_required([:conversation_type, :conversation_status])
  end
end
