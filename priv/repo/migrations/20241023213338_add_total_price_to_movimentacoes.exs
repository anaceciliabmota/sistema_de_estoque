defmodule Project.Repo.Migrations.AddTotalPriceToMovimentacoes do
  use Ecto.Migration

  def change do
    alter table(:movimentacoes) do
      add :total_price, :decimal
    end
  end
end
