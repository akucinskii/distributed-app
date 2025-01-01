defmodule DistributedApi.Repo.Migrations.CreateBoxes do
  use Ecto.Migration

  def change do
    create table(:boxes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
