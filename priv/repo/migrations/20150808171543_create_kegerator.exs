defmodule Kegster.Repo.Migrations.CreateKegerator do
  use Ecto.Migration

  def change do
    create table(:kegerators) do
      add :name, :string

      timestamps
    end

  end
end
