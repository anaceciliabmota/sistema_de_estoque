defmodule ProjectWeb.ProdutoHTML do
  use ProjectWeb, :html

  embed_templates "produto_html/*"

  @doc """
  Renders a produto form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :fornecedores, :list, required: true

  def produto_form(assigns)
end
