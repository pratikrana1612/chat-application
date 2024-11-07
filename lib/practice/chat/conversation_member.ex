defmodule Practice.Chat.ConversationMember do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_conversation_members" do
    field :owner, :boolean, default: false
    # field :conversation_id, :id
    # field :user_id, :id

    belongs_to :user, Practice.Auth.User
    belongs_to :conversation, Practice.Chat.Conversation

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(conversation_member, attrs) do
    conversation_member
    |> cast(attrs, [:owner, :conversation_id, :user_id])
    |> validate_required([:owner, :conversation_id, :user_id])
    |> unique_constraint(:user, name: :chat_conversation_members_conversation_id_user_id_index)
    |> unique_constraint(:conversation_id,
      name: :chat_conversation_members_owner
    )
  end
end
