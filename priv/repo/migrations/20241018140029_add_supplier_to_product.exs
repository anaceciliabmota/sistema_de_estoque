defmodule Project.Repo.Migrations.AddSupplierToProduct do
  use Ecto.Migration

  def change do
    alter table(:produtos) do
      add :fornecedor_id, references(:fornecedores, on_delete: :nothing)
    end

  end
end
