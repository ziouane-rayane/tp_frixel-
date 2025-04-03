defmodule IgIntranet.Repo.Migrations.CreateLogs do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :log_event, :string
      add :user_email, :string

      timestamps(type: :utc_datetime)
    end
  end
end
