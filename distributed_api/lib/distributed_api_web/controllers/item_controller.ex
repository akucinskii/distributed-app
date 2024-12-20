defmodule DistributedApiWeb.ItemController do
  use DistributedApiWeb, :controller

  alias DistributedApi.Items
  alias DistributedApi.Boxes
  alias DistributedApi.Items.Item

  def index(conn, _params) do
    items = Items.list_items()
    render(conn, :index, items: items)
  end

  def new(conn, _params) do
    changeset = Items.change_item(%Item{})
    boxes = Boxes.list_boxes() |> Enum.map(&{&1.name, &1.id})
    render(conn, :new, changeset: changeset, boxes: boxes)
  end

  def create(conn, %{"item" => item_params}) do
    case Items.create_item(item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect(to: ~p"/items/#{item}")

      {:error, %Ecto.Changeset{} = changeset} ->
        boxes = Boxes.list_boxes() |> Enum.map(&{&1.name, &1.id})
        render(conn, :new, changeset: changeset, boxes: boxes)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Items.get_item!(id)
    render(conn, :show, item: item)
  end

  def edit(conn, %{"id" => id}) do
    item = Items.get_item!(id)
    changeset = Items.change_item(item)
    boxes = Boxes.list_boxes() |> Enum.map(&{&1.name, &1.id})

    render(conn, :edit,
      item: item,
      changeset: changeset,
      boxes: boxes
    )
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Items.get_item!(id)

    case Items.update_item(item, item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: ~p"/items/#{item}")

      {:error, %Ecto.Changeset{} = changeset} ->
        boxes = Boxes.list_boxes() |> Enum.map(&{&1.name, &1.id})

        render(conn, :edit,
          item: item,
          changeset: changeset,
          boxes: boxes
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Items.get_item!(id)
    {:ok, _item} = Items.delete_item(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: ~p"/items")
  end
end
