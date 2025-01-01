defmodule DistributedApiWeb.BoxController do
  use DistributedApiWeb, :controller

  alias DistributedApi.Boxes
  alias DistributedApi.Boxes.Box

  def index(conn, _params) do
    boxes = Boxes.list_boxes()
    render(conn, :index, boxes: boxes)
  end

  def new(conn, _params) do
    changeset = Boxes.change_box(%Box{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"box" => box_params}) do
    case Boxes.create_box(box_params) do
      {:ok, box} ->
        conn
        |> put_flash(:info, "Box created successfully.")
        |> redirect(to: ~p"/boxes/#{box}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    box = Boxes.get_box!(id)

    box_items = Boxes.get_box_items(box)
    render(conn, :show, box: box, box_items: box_items)
  end

  def edit(conn, %{"id" => id}) do
    box = Boxes.get_box!(id)
    changeset = Boxes.change_box(box)
    render(conn, :edit, box: box, changeset: changeset)
  end

  def update(conn, %{"id" => id, "box" => box_params}) do
    box = Boxes.get_box!(id)

    case Boxes.update_box(box, box_params) do
      {:ok, box} ->
        conn
        |> put_flash(:info, "Box updated successfully.")
        |> redirect(to: ~p"/boxes/#{box}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, box: box, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    box = Boxes.get_box!(id)
    {:ok, _box} = Boxes.delete_box(box)

    conn
    |> put_flash(:info, "Box deleted successfully.")
    |> redirect(to: ~p"/boxes")
  end
end
