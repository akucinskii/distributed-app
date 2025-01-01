defmodule DistributedApi.ItemsLiveTest do
  use DistributedApi.DataCase

  alias DistributedApi.ItemsLive

  describe "items_live" do
    alias DistributedApi.ItemsLive.ItemLive

    import DistributedApi.ItemsLiveFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_items_live/0 returns all items_live" do
      item_live = item_live_fixture()
      assert ItemsLive.list_items_live() == [item_live]
    end

    test "get_item_live!/1 returns the item_live with given id" do
      item_live = item_live_fixture()
      assert ItemsLive.get_item_live!(item_live.id) == item_live
    end

    test "create_item_live/1 with valid data creates a item_live" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %ItemLive{} = item_live} = ItemsLive.create_item_live(valid_attrs)
      assert item_live.name == "some name"
      assert item_live.description == "some description"
    end

    test "create_item_live/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ItemsLive.create_item_live(@invalid_attrs)
    end

    test "update_item_live/2 with valid data updates the item_live" do
      item_live = item_live_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %ItemLive{} = item_live} = ItemsLive.update_item_live(item_live, update_attrs)
      assert item_live.name == "some updated name"
      assert item_live.description == "some updated description"
    end

    test "update_item_live/2 with invalid data returns error changeset" do
      item_live = item_live_fixture()
      assert {:error, %Ecto.Changeset{}} = ItemsLive.update_item_live(item_live, @invalid_attrs)
      assert item_live == ItemsLive.get_item_live!(item_live.id)
    end

    test "delete_item_live/1 deletes the item_live" do
      item_live = item_live_fixture()
      assert {:ok, %ItemLive{}} = ItemsLive.delete_item_live(item_live)
      assert_raise Ecto.NoResultsError, fn -> ItemsLive.get_item_live!(item_live.id) end
    end

    test "change_item_live/1 returns a item_live changeset" do
      item_live = item_live_fixture()
      assert %Ecto.Changeset{} = ItemsLive.change_item_live(item_live)
    end
  end
end
