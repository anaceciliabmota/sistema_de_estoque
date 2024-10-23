defmodule Project.Estoque.Movimentacao do
  use Ecto.Schema
  import Ecto.Changeset
  alias Project.Repo
  alias Project.Estoque.Produto

  schema "movimentacoes" do
    field :date, :naive_datetime
    field :movement_type, :string
    field :quantity, :integer
    field :total_price, :decimal
    field :remarks, :string

    belongs_to :produto, Project.Estoque.Produto

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(movimentacao, attrs) do
    movimentacao
    |> cast(attrs, [:movement_type, :quantity, :remarks, :produto_id])
    |> validate_required([:movement_type, :quantity, :remarks, :produto_id])
    |> calculate_total_price()
  end

  defp calculate_total_price(changeset) do
    quantidade = get_field(changeset, :quantity)
    produto_id = get_field(changeset, :produto_id)

    if quantidade && produto_id do
      produto = Repo.get!(Produto, produto_id)
      preco_total = Decimal.mult(Decimal.new(quantidade), produto.price)

      put_change(changeset, :total_price, preco_total)
    else
      changeset
    end
  end
end
