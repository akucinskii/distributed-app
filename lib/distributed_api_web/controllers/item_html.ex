defmodule DistributedApiWeb.ItemHTML do
  use DistributedApiWeb, :html

  embed_templates("item_html/*")

  @doc """
  Renders a item form.
  """
  attr(:changeset, Ecto.Changeset, required: true)
  attr(:action, :string, required: true)

  def item_form(assigns)
end
