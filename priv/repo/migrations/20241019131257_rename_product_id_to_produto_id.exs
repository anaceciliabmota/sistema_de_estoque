defmodule Project.Repo.Migrations.RenameProductIdToProdutoId do
  use Ecto.Migration

  def change do
    rename table(:movimentacoes), :product_id, to: :produto_id

  end
end
