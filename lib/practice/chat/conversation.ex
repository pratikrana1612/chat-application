defmodule Practice.Chat.Conversation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_conversations" do
    field :title, :string
    has_many :conversation_members, Practice.Chat.ConversationMember
    has_many :messages, Practice.Chat.Message
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
