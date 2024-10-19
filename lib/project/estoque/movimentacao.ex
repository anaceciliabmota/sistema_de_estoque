defmodule Project.Estoque.Movimentacao do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movimentacoes" do
    field :date, :naive_datetime
    field :movement_type, :string
    field :quantity, :integer
    field :remarks, :string

    belongs_to :produto, Project.Estoque.Produto

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(movimentacao, attrs) do
    movimentacao
    |> cast(attrs, [:movement_type, :quantity, :date, :remarks, :produto_id])
    |> validate_required([:movement_type, :quantity, :date, :remarks, :produto_id])
  end
end
