defmodule IgIntranet.Repo.Migrations.AddMetaData do
  use Ecto.Migration

  def change do
    alter table(:intranet_messages) do
      add :meta_data, :map, default: %{}
    end
  end
end
