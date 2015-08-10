defmodule Kegster.Repo.Migrations.CreateKeg do
  use Ecto.Migration

  def change do
    create table(:kegs) do
      add :beer_id, references(:beers), on_delete: :delete_all
      add :tapped_at, :datetime
      add :floated_at, :datetime
      add :left_kegerator_handle_id, references(:kegerators), on_delete: :delete_all
      add :right_kegerator_handle_id, references(:kegerators), on_delete: :delete_all

      timestamps
    end

  end
end
