defmodule Project.Estoque.Fornecedor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fornecedores" do
    field :address, :string
    field :email, :string
    field :name, :string
    field :phone, :string

    has_many :produtos, Project.Estoque.Produto

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(fornecedor, attrs) do
    fornecedor
    |> cast(attrs, [:name, :address, :email, :phone])
    |> validate_required([:name, :address, :email, :phone])
  end
end
