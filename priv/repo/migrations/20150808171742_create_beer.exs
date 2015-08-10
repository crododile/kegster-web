defmodule Kegster.Repo.Migrations.CreateBeer do
  use Ecto.Migration

  def change do
    create table(:beers) do
      add :name, :string
      add :alcohol_content, :decimal, precision: 3, scale: 1
      add :color, :string
      add :type, :string

      timestamps
    end

  end
end
