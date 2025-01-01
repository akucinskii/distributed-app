defmodule DistributedApi.ItemsLiveFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DistributedApi.ItemsLive` context.
  """

  @doc """
  Generate a item_live.
  """
  def item_live_fixture(attrs \\ %{}) do
    {:ok, item_live} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> DistributedApi.ItemsLive.create_item_live()

    item_live
  end
end
