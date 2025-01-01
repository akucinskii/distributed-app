defmodule DistributedApi.BoxesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DistributedApi.Boxes` context.
  """

  @doc """
  Generate a box.
  """
  def box_fixture(attrs \\ %{}) do
    {:ok, box} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> DistributedApi.Boxes.create_box()

    box
  end
end
