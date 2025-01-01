defmodule DistributedApi.BoxesLiveTest do
  use DistributedApi.DataCase

  alias DistributedApi.BoxesLive

  describe "boxes_live" do
    alias DistributedApi.BoxesLive.BoxLive

    import DistributedApi.BoxesLiveFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_boxes_live/0 returns all boxes_live" do
      box_live = box_live_fixture()
      assert BoxesLive.list_boxes_live() == [box_live]
    end

    test "get_box_live!/1 returns the box_live with given id" do
      box_live = box_live_fixture()
      assert BoxesLive.get_box_live!(box_live.id) == box_live
    end

    test "create_box_live/1 with valid data creates a box_live" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %BoxLive{} = box_live} = BoxesLive.create_box_live(valid_attrs)
      assert box_live.name == "some name"
      assert box_live.description == "some description"
    end

    test "create_box_live/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BoxesLive.create_box_live(@invalid_attrs)
    end

    test "update_box_live/2 with valid data updates the box_live" do
      box_live = box_live_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %BoxLive{} = box_live} = BoxesLive.update_box_live(box_live, update_attrs)
      assert box_live.name == "some updated name"
      assert box_live.description == "some updated description"
    end

    test "update_box_live/2 with invalid data returns error changeset" do
      box_live = box_live_fixture()
      assert {:error, %Ecto.Changeset{}} = BoxesLive.update_box_live(box_live, @invalid_attrs)
      assert box_live == BoxesLive.get_box_live!(box_live.id)
    end

    test "delete_box_live/1 deletes the box_live" do
      box_live = box_live_fixture()
      assert {:ok, %BoxLive{}} = BoxesLive.delete_box_live(box_live)
      assert_raise Ecto.NoResultsError, fn -> BoxesLive.get_box_live!(box_live.id) end
    end

    test "change_box_live/1 returns a box_live changeset" do
      box_live = box_live_fixture()
      assert %Ecto.Changeset{} = BoxesLive.change_box_live(box_live)
    end
  end
end
