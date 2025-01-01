defmodule DistributedApi.Boxes.Box do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "boxes" do
    field(:name, :string)
    field(:description, :string)
    has_many(:items, DistributedApi.Items.Item)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(box, attrs) do
    box
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
