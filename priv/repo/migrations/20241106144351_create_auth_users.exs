defmodule Practice.Repo.Migrations.CreateAuthUsers do
  use Ecto.Migration

  def change do
    create table(:auth_users) do
      add :nickname, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:auth_users, [:nickname])
  end
end
