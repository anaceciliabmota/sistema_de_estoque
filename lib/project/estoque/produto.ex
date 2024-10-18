defmodule Project.Estoque.Produto do
  use Ecto.Schema
  import Ecto.Changeset

  schema "produtos" do
    field :description, :string
    field :name, :string
    field :price, :decimal
    field :quantity, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(produto, attrs) do
    produto
    |> cast(attrs, [:name, :description, :price, :quantity])
    |> validate_required([:name, :description, :price, :quantity])
  end
end
