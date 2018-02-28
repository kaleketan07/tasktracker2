defmodule Tasktracker.Repo.Migrations.AddManagerColumn do
  use Ecto.Migration

  def change do
    alter table(:users) do
      # implicit: id auto-incremented integer
      add :manager_id, :id
    end
  end
end
