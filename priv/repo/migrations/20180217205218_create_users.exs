defmodule Tasktracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      # implicit: id auto-incremented integer
      add :email, :string, null: false
      add :name, :string, null: false

      timestamps()
      # inserted_at
      # updated_at
    end

  end
end
