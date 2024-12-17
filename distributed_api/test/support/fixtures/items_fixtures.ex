defmodule DistributedApi.ItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DistributedApi.Items` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> DistributedApi.Items.create_item()

    item
  end
end
