defmodule AuthorizationWithPow.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string
      add :username, :string, null: false
      add :first_name, :string
      add :last_name, :string

      timestamps()
    end

    create unique_index(:users, [:email, :username])
  end
end
