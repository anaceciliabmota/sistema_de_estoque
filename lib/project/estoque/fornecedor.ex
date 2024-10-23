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
    |> normalize_name()  # Normalizar o nome antes da validação de unicidade
    |> unique_constraint(:name, name: :unique_fornecedor_name, message: "Já existe um fornecedor com esse nome")
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
