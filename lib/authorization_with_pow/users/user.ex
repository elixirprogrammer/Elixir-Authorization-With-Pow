defmodule AuthorizationWithPow.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()

    field :username, :string
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:username, :first_name, :last_name])
    |> Ecto.Changeset.validate_required([:username, :first_name, :last_name])
    |> Ecto.Changeset.validate_length(:first_name, min: 2)
    |> Ecto.Changeset.validate_length(:last_name, min: 2)
    |> Ecto.Changeset.unique_constraint(:email)
    |> Ecto.Changeset.unique_constraint(:username)
  end
end
