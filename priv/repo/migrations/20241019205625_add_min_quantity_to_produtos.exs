defmodule Project.Repo.Migrations.AddMinQuantityToProdutos do
  use Ecto.Migration

  def change do
    alter table(:produtos) do
      add :min_quantity, :integer, default: 500
    end
  end
end
