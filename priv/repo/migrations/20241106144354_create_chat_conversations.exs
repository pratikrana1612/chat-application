defmodule Practice.Repo.Migrations.CreateChatConversations do
  use Ecto.Migration

  def change do
    create table(:chat_conversations) do
      add :title, :string

      timestamps(type: :utc_datetime)
    end
  end
end
