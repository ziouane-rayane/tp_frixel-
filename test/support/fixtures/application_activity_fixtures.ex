defmodule IgIntranet.ApplicationActivityFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IgIntranet.ApplicationActivity` context.
  """

  @doc """
  Generate a log.
  """
  def log_fixture(attrs \\ %{}) do
    {:ok, log} =
      attrs
      |> Enum.into(%{
        log_event: "some log_event",
        user_email: "some user_email"
      })
      |> IgIntranet.ApplicationActivity.create_log()

    log
  end
end
