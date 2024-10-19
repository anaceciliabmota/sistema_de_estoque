defmodule ProjectWeb.MovimentacaoHTML do
  use ProjectWeb, :html

  embed_templates "movimentacao_html/*"

  @doc """
  Renders a movimentacao form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :produtos, :list, required: true

  def movimentacao_form(assigns)
end
