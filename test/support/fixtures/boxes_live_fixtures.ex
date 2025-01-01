defmodule DistributedApi.BoxesLiveFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DistributedApi.BoxesLive` context.
  """

  @doc """
  Generate a box_live.
  """
  def box_live_fixture(attrs \\ %{}) do
    {:ok, box_live} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> DistributedApi.BoxesLive.create_box_live()

    box_live
  end
end
