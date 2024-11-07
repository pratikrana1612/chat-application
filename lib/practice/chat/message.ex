defmodule Practice.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_messages" do
    field :content, :string
    # field :conversation_id, :id
    # field :user_id, :id

    belongs_to :conversation, Practice.Chat.Conversation
    belongs_to :user, Practice.Auth.User

    has_many :seen_messages, Practice.Chat.SeenMessage

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :conversation_id, :user_id])
    |> validate_required([:content, :conversation_id, :user_id])
  end
end
