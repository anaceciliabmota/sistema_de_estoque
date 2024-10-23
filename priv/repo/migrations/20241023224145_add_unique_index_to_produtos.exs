defmodule Project.Repo.Migrations.AddUniqueIndexToProdutos do
  use Ecto.Migration

  def change do
    create unique_index(:produtos, [:name], name: :unique_produto_name)
  end
end
