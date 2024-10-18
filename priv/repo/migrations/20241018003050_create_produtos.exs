defmodule Project.Repo.Migrations.CreateProdutos do
  use Ecto.Migration

  def change do
    create table(:produtos) do
      add :name, :string
      add :description, :text
      add :price, :decimal
      add :quantity, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
