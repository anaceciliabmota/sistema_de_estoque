defmodule Project.Repo.Migrations.AddUniqueIndexToFornecedores do
  use Ecto.Migration

  def change do
    create unique_index(:fornecedores, [:name], name: :unique_fornecedor_name)
  end
end
