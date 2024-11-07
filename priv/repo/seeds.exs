# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Practice.Repo.insert!(%Practice.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Practice.Auth.User
alias Practice.Chat.{Conversation, ConversationMember}

alias Practice.{Auth, Chat}

{:ok, %User{id: u1_id}} = Auth.create_user(%{nickname: "User One"})
{:ok, %User{id: u2_id}} = Auth.create_user(%{nickname: "User Two"})

{:ok, %Conversation{id: conv_id}} = Chat.create_conversation(%{title: "Modern Talking"})

{:ok, %ConversationMember{}} =
  Chat.create_conversation_member(%{conversation_id: conv_id, user_id: u1_id, owner: true})

{:ok, %ConversationMember{}} =
  Chat.create_conversation_member(%{conversation_id: conv_id, user_id: u2_id, owner: false})
