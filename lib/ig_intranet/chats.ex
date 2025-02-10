defmodule IgIntranet.Chats do
  @moduledoc """
  The Chats context.
  """

  import Ecto.Query, warn: false
  alias IgIntranet.Repo

  alias IgIntranet.Chats.IntranetConversation

  @doc """
  Returns the list of intranet_conversations.

  ## Examples

      iex> list_intranet_conversations()
      [%IntranetConversation{}, ...]

  """
  def list_intranet_conversations do
    Repo.all(IntranetConversation)
  end

  @doc """
  Gets a single intranet_conversation.

  Raises `Ecto.NoResultsError` if the Intranet conversation does not exist.

  ## Examples

      iex> get_intranet_conversation!(123)
      %IntranetConversation{}

      iex> get_intranet_conversation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_intranet_conversation!(id), do: Repo.get!(IntranetConversation, id)

  @doc """
  Creates a intranet_conversation.

  ## Examples

      iex> create_intranet_conversation(%{field: value})
      {:ok, %IntranetConversation{}}

      iex> create_intranet_conversation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_intranet_conversation(attrs \\ %{}) do
    %IntranetConversation{}
    |> IntranetConversation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a intranet_conversation.

  ## Examples

      iex> update_intranet_conversation(intranet_conversation, %{field: new_value})
      {:ok, %IntranetConversation{}}

      iex> update_intranet_conversation(intranet_conversation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_intranet_conversation(%IntranetConversation{} = intranet_conversation, attrs) do
    intranet_conversation
    |> IntranetConversation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a intranet_conversation.

  ## Examples

      iex> delete_intranet_conversation(intranet_conversation)
      {:ok, %IntranetConversation{}}

      iex> delete_intranet_conversation(intranet_conversation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_intranet_conversation(%IntranetConversation{} = intranet_conversation) do
    Repo.delete(intranet_conversation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking intranet_conversation changes.

  ## Examples

      iex> change_intranet_conversation(intranet_conversation)
      %Ecto.Changeset{data: %IntranetConversation{}}

  """
  def change_intranet_conversation(%IntranetConversation{} = intranet_conversation, attrs \\ %{}) do
    IntranetConversation.changeset(intranet_conversation, attrs)
  end
end
