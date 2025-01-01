defmodule DistributedApiWeb.BoxHTML do
  use DistributedApiWeb, :html

  embed_templates "box_html/*"

  @doc """
  Renders a box form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def box_form(assigns)
end
