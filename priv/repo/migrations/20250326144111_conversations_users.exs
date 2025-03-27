defmodule IgIntranet.Repo.Migrations.ConversationsUsers do
  use Ecto.Migration

  def change do
    create table("conversations_users", primary_key: false) do
      add :user_id,
          references(:users, on_delete: :delete_all),
          null: false

      add :conversation_id,
          references(:intranet_conversations, on_delete: :delete_all),
          null: false

      timestamps()
    end

    create unique_index(:conversations_users, [:user_id, :conversation_id])
  end
end
