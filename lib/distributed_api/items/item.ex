defmodule DistributedApi.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "items" do
    field(:name, :string)
    field(:description, :string)
    timestamps(type: :utc_datetime)
    belongs_to(:box, DistributedApi.Boxes.Box)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :description, :box_id])
    |> validate_required([:name, :description, :box_id])
    |> assoc_constraint(:box)
  end
end
