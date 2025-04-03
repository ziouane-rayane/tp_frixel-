defmodule IgIntranet.ApplicationActivity.Log do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logs" do
    field :log_event, :string
    field :user_email, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:log_event, :user_email])
    |> validate_required([:log_event, :user_email])
  end
end
