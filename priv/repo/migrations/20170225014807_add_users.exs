defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :auth_provider, :string
      add :auth_token, :string
      add :username, :string
      add :status, :string, default: "Active"
      add :image_url, :string
      timestamps()
    end
  end
end
