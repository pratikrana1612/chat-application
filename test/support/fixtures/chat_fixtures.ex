defmodule Practice.ChatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Practice.Chat` context.
  """

  @doc """
  Generate a conversation.
  """
  def conversation_fixture(attrs \\ %{}) do
    {:ok, conversation} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Practice.Chat.create_conversation()

    conversation
  end

  @doc """
  Generate a conversation_member.
  """
  def conversation_member_fixture(attrs \\ %{}) do
    {:ok, conversation_member} =
      attrs
      |> Enum.into(%{
        owner: true
      })
      |> Practice.Chat.create_conversation_member()

    conversation_member
  end

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> Practice.Chat.create_message()

    message
  end

  @doc """
  Generate a seen_message.
  """
  def seen_message_fixture(attrs \\ %{}) do
    {:ok, seen_message} =
      attrs
      |> Enum.into(%{

      })
      |> Practice.Chat.create_seen_message()

    seen_message
  end
end
