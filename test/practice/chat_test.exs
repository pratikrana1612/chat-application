defmodule Practice.ChatTest do
  use Practice.DataCase

  alias Practice.Chat

  describe "chat_conversations" do
    alias Practice.Chat.Conversation

    import Practice.ChatFixtures

    @invalid_attrs %{title: nil}

    test "list_chat_conversations/0 returns all chat_conversations" do
      conversation = conversation_fixture()
      assert Chat.list_chat_conversations() == [conversation]
    end

    test "get_conversation!/1 returns the conversation with given id" do
      conversation = conversation_fixture()
      assert Chat.get_conversation!(conversation.id) == conversation
    end

    test "create_conversation/1 with valid data creates a conversation" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Conversation{} = conversation} = Chat.create_conversation(valid_attrs)
      assert conversation.title == "some title"
    end

    test "create_conversation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_conversation(@invalid_attrs)
    end

    test "update_conversation/2 with valid data updates the conversation" do
      conversation = conversation_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Conversation{} = conversation} = Chat.update_conversation(conversation, update_attrs)
      assert conversation.title == "some updated title"
    end

    test "update_conversation/2 with invalid data returns error changeset" do
      conversation = conversation_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_conversation(conversation, @invalid_attrs)
      assert conversation == Chat.get_conversation!(conversation.id)
    end

    test "delete_conversation/1 deletes the conversation" do
      conversation = conversation_fixture()
      assert {:ok, %Conversation{}} = Chat.delete_conversation(conversation)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_conversation!(conversation.id) end
    end

    test "change_conversation/1 returns a conversation changeset" do
      conversation = conversation_fixture()
      assert %Ecto.Changeset{} = Chat.change_conversation(conversation)
    end
  end

  describe "chat_conversation_members" do
    alias Practice.Chat.ConversationMember

    import Practice.ChatFixtures

    @invalid_attrs %{owner: nil}

    test "list_chat_conversation_members/0 returns all chat_conversation_members" do
      conversation_member = conversation_member_fixture()
      assert Chat.list_chat_conversation_members() == [conversation_member]
    end

    test "get_conversation_member!/1 returns the conversation_member with given id" do
      conversation_member = conversation_member_fixture()
      assert Chat.get_conversation_member!(conversation_member.id) == conversation_member
    end

    test "create_conversation_member/1 with valid data creates a conversation_member" do
      valid_attrs = %{owner: true}

      assert {:ok, %ConversationMember{} = conversation_member} = Chat.create_conversation_member(valid_attrs)
      assert conversation_member.owner == true
    end

    test "create_conversation_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_conversation_member(@invalid_attrs)
    end

    test "update_conversation_member/2 with valid data updates the conversation_member" do
      conversation_member = conversation_member_fixture()
      update_attrs = %{owner: false}

      assert {:ok, %ConversationMember{} = conversation_member} = Chat.update_conversation_member(conversation_member, update_attrs)
      assert conversation_member.owner == false
    end

    test "update_conversation_member/2 with invalid data returns error changeset" do
      conversation_member = conversation_member_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_conversation_member(conversation_member, @invalid_attrs)
      assert conversation_member == Chat.get_conversation_member!(conversation_member.id)
    end

    test "delete_conversation_member/1 deletes the conversation_member" do
      conversation_member = conversation_member_fixture()
      assert {:ok, %ConversationMember{}} = Chat.delete_conversation_member(conversation_member)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_conversation_member!(conversation_member.id) end
    end

    test "change_conversation_member/1 returns a conversation_member changeset" do
      conversation_member = conversation_member_fixture()
      assert %Ecto.Changeset{} = Chat.change_conversation_member(conversation_member)
    end
  end

  describe "chat_messages" do
    alias Practice.Chat.Message

    import Practice.ChatFixtures

    @invalid_attrs %{content: nil}

    test "list_chat_messages/0 returns all chat_messages" do
      message = message_fixture()
      assert Chat.list_chat_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Chat.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{content: "some content"}

      assert {:ok, %Message{} = message} = Chat.create_message(valid_attrs)
      assert message.content == "some content"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{content: "some updated content"}

      assert {:ok, %Message{} = message} = Chat.update_message(message, update_attrs)
      assert message.content == "some updated content"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_message(message, @invalid_attrs)
      assert message == Chat.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Chat.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Chat.change_message(message)
    end
  end

  describe "chat_seen_messages" do
    alias Practice.Chat.SeenMessage

    import Practice.ChatFixtures

    @invalid_attrs %{}

    test "list_chat_seen_messages/0 returns all chat_seen_messages" do
      seen_message = seen_message_fixture()
      assert Chat.list_chat_seen_messages() == [seen_message]
    end

    test "get_seen_message!/1 returns the seen_message with given id" do
      seen_message = seen_message_fixture()
      assert Chat.get_seen_message!(seen_message.id) == seen_message
    end

    test "create_seen_message/1 with valid data creates a seen_message" do
      valid_attrs = %{}

      assert {:ok, %SeenMessage{} = seen_message} = Chat.create_seen_message(valid_attrs)
    end

    test "create_seen_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_seen_message(@invalid_attrs)
    end

    test "update_seen_message/2 with valid data updates the seen_message" do
      seen_message = seen_message_fixture()
      update_attrs = %{}

      assert {:ok, %SeenMessage{} = seen_message} = Chat.update_seen_message(seen_message, update_attrs)
    end

    test "update_seen_message/2 with invalid data returns error changeset" do
      seen_message = seen_message_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_seen_message(seen_message, @invalid_attrs)
      assert seen_message == Chat.get_seen_message!(seen_message.id)
    end

    test "delete_seen_message/1 deletes the seen_message" do
      seen_message = seen_message_fixture()
      assert {:ok, %SeenMessage{}} = Chat.delete_seen_message(seen_message)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_seen_message!(seen_message.id) end
    end

    test "change_seen_message/1 returns a seen_message changeset" do
      seen_message = seen_message_fixture()
      assert %Ecto.Changeset{} = Chat.change_seen_message(seen_message)
    end
  end
end
