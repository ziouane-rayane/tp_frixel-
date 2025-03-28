defmodule IgIntranet.Chats.IntranetConversation do
  @moduledoc """
    Intranet_conversations représente les conversations de l'intranet.
    Une conversation a plusieurs types, publique ou privée.
    Une conversation a plusieurs statuts, actives ou archivées.
    Une conversation contient plusieurs messages, ils sont rattachés par la relation suivante: intranet_conversation has_many intranet_messages.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias IgIntranet.Chats.IntranetMessage
    alias IgIntranet.Repo

  @derive {
    Flop.Schema,
    filterable: [
      :conversation_type,
      :conversation_status,
      :conversation_topic,
      :inserted_at,
      :updated_at,
      :message_body
    ],
    sortable: [
      :conversation_type,
      :conversation_status,
      :conversation_topic,
      :inserted_at,
      :updated_at,
      :message_body
    ],
    adapter_opts: [
      join_fields: [
        message_body: [
          binding: :intranet_messages,
          field: :message_body,
          ecto_type: :string
        ]
      ]
    ],
    default_limit: 4
  }

  schema "intranet_conversations" do
    field :conversation_type, Ecto.Enum, values: [:public, :private]
    field :conversation_status, Ecto.Enum, values: [:active, :archived]
    field :conversation_topic, :string

    many_to_many :users, IgIntranet.Accounts.User, join_through: "conversations_users"
    has_many(:intranet_messages, IntranetMessage, on_delete: :delete_all)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(intranet_conversation, attrs) do
    intranet_conversation
    |> cast(attrs, [:conversation_type, :conversation_status, :conversation_topic])
    |> validate_required([:conversation_type, :conversation_status, :conversation_topic])
    |> unique_constraint(:conversation_topic)
    |> cast_assoc(:intranet_messages, with: &IntranetMessage.changeset_with_conversation/2)
  end

  def changeset_many_to_many(intranet_conversation, attrs) do
    intranet_conversation
    |> changeset(attrs)
    |> put_assoc(
    :users,
    attrs
    |> Map.get("user_ids")
    |> Enum.map(fn user_id ->
      Repo.get(IgIntranet.Accounts.User, user_id)
    end)
  )
  end
end
