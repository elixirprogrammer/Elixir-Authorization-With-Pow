defmodule AuthorizationWithPow.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema,
    extensions: [PowResetPassword]


  import Ecto.Changeset

  alias AuthorizationWithPow.Users.User
  alias AuthorizationWithPow.Repo

  schema "users" do
    pow_user_fields()

    field :username, :string
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> pow_extension_changeset(attrs)
    |> cast(attrs, [:username, :first_name, :last_name])
    |> validate_required([:username, :first_name, :last_name])
    |> validate_length(:first_name, min: 2)
    |> validate_length(:last_name, min: 2)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def profile(param) do
    Repo.get_by(User, username: param)
  end
end
