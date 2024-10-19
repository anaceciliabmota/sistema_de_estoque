defmodule Project.Estoque.Produto do
  use Ecto.Schema
  import Ecto.Changeset

  schema "produtos" do
    field :description, :string
    field :name, :string
    field :price, :decimal
    field :quantity, :integer, default: 0

    belongs_to :fornecedor, Project.Estoque.Fornecedor
    has_many :movimentacoes, Project.Estoque.Movimentacao

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(produto, attrs) do
    produto
    |> cast(attrs, [:name, :description, :price, :quantity, :fornecedor_id])
    |> validate_required([:name, :description, :price, :fornecedor_id])
    |> put_default_quantity()
  end

  defp put_default_quantity(changeset) do
    case get_field(changeset, :quantity) do
      nil -> put_change(changeset, :quantity, 0)
      _ -> changeset
    end
  end
end
