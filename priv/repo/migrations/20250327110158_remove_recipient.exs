defmodule IgIntranet.Repo.Migrations.RemoveRecipient do
  use Ecto.Migration

  def change do
    drop index(:intranet_messages, [:recipient_id])
    alter table(:intranet_messages) do
      remove :recipient_id
    end
  end
end
