defmodule Practice.Chat.SeenMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_seen_messages" do
    # field :user_id, :id
    # field :message_id, :id
    belongs_to :user, Practice.Auth.User
    belongs_to :message, Practice.Chat.Message

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(seen_message, attrs) do
    seen_message
    |> cast(attrs, [:user_id, :message_id])
    |> validate_required([:user_id, :message_id])
  end
end
