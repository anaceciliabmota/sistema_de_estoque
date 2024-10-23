defmodule Project.Estoque.Produto do
  use Ecto.Schema
  import Ecto.Changeset

  schema "produtos" do
    field :description, :string
    field :name, :string
    field :price, :decimal
    field :quantity, :integer, default: 0
    field :min_quantity, :integer, default: 500  # Quantidade mínima para alerta de estoque baixo

    belongs_to :fornecedor, Project.Estoque.Fornecedor
    has_many :movimentacoes, Project.Estoque.Movimentacao, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(produto, attrs) do
    produto
    |> cast(attrs, [:name, :description, :price, :quantity, :min_quantity, :fornecedor_id])
    |> validate_required([:name, :description, :price, :fornecedor_id])
    |> put_default_quantity()
    |> validate_min_quantity()
    |> normalize_name()
    |> unique_constraint(:name, name: :unique_produto_name, message: "Já existe um produto com esse nome")
  end

  # Garante que o campo 'quantity' tenha um valor padrão de 0, se não for definido
  defp put_default_quantity(changeset) do
    case get_field(changeset, :quantity) do
      nil -> put_change(changeset, :quantity, 0)
      _ -> changeset
    end
  end

  # Validação para garantir que a quantidade mínima seja maior que zero
  defp validate_min_quantity(changeset) do
    validate_number(changeset, :min_quantity, greater_than_or_equal_to: 0)
  end

  defp normalize_name(changeset) do
    update_change(changeset, :name, &capitalize_name/1)
  end

  defp capitalize_name(name) do
    name
    |> String.downcase()
    |> String.split(" ")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end
end
