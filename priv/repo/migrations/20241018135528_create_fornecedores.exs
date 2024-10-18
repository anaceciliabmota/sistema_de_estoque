defmodule Project.Repo.Migrations.CreateFornecedores do
  use Ecto.Migration

  def change do
    create table(:fornecedores) do
      add :name, :string
      add :address, :text
      add :email, :text
      add :phone, :string

      timestamps(type: :utc_datetime)
    end
  end
end
