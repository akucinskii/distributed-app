defmodule DistributedApi.Repo.Migrations.LinkItemsToBoxes do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add(:box_id, references(:boxes, type: :uuid, on_delete: :nothing))
    end

    create(index(:items, [:box_id]))
  end
end
