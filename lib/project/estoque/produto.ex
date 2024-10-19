defmodule Project.Estoque.Produto do
  use Ecto.Schema
  import Ecto.Changeset

  schema "produtos" do
    field :description, :string
    field :name, :string
    field :price, :decimal
    field :quantity, :integer

    belongs_to :fornecedor, Project.Estoque.Fornecedor
    has_many :movimentacoes, Project.Estoque.Movimentacao

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(produto, attrs) do
    produto
    |> cast(attrs, [:name, :description, :price, :quantity, :fornecedor_id])
    |> validate_required([:name, :description, :price, :quantity, :fornecedor_id])
  end
end
