defmodule Practice.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  use Pow.Ecto.Schema

  schema "auth_users" do
    field :nickname, :string
    pow_user_fields()
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:nickname])
    |> pow_changeset(attrs)
    |> validate_required([:nickname])
    |> unique_constraint(:nickname)
  end
end
