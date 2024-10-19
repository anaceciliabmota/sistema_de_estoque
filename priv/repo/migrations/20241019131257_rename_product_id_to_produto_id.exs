defmodule Project.Repo.Migrations.RenameProductIdToProdutoId do
  use Ecto.Migration

  def up do
    execute("""
    DO $$
    BEGIN
      IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'movimentacoes' AND column_name = 'product_id') THEN
        ALTER TABLE movimentacoes RENAME COLUMN product_id TO produto_id;
      END IF;
    END $$;
    """)
  end

  def down do
    # Opcional: você pode fazer o inverso aqui, se necessário
  end
end
