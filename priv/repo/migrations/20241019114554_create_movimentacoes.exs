defmodule Project.Repo.Migrations.CreateMovimentacoes do
  use Ecto.Migration

  def change do
    create table(:movimentacoes) do
      add :movement_type, :string
      add :quantity, :integer
      add :date, :naive_datetime
      add :remarks, :text
      add :produto_id, references(:produtos, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:movimentacoes, [:produto_id])
  end
end
