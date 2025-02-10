defmodule IgIntranet.ChatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IgIntranet.Chats` context.
  """

  @doc """
  Generate a intranet_conversation.
  """
  def intranet_conversation_fixture(attrs \\ %{}) do
    {:ok, intranet_conversation} =
      attrs
      |> Enum.into(%{
        conversation_type: "public",
        conversation_status: "active"
      })
      |> IgIntranet.Chats.create_intranet_conversation()

    intranet_conversation
  end
end
