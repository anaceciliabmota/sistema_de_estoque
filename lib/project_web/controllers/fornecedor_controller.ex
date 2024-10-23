defmodule ProjectWeb.FornecedorController do
  use ProjectWeb, :controller

  alias Project.Estoque
  alias Project.Estoque.Fornecedor

  def index(conn, _params) do
    fornecedores = Estoque.list_fornecedores()
    render(conn, :index, fornecedores: fornecedores)
  end

  def new(conn, _params) do
    changeset = Estoque.change_fornecedor(%Fornecedor{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"fornecedor" => fornecedor_params}) do
    case Estoque.create_fornecedor(fornecedor_params) do
      {:ok, fornecedor} ->
        conn
        |> put_flash(:info, "Fornecedor created successfully.")
        |> redirect(to: ~p"/fornecedores/#{fornecedor}")

      {:error, %Ecto.Changeset{} = changeset} ->
        if changeset.errors[:name] do
          conn
          |> put_flash(:error, "Erro: Já existe um fornecedor com esse nome. Escolha outro nome.")
          |> render(:new, changeset: changeset)
        else
          render(conn, :new, changeset: changeset)
        end
    end
  end

  def show(conn, %{"id" => id} = params) do
    fornecedor = Estoque.get_fornecedor!(id)

    source = Map.get(params, "source")

    if source == "estoque_baixo" do
      render(conn, :show_from_estoque, fornecedor: fornecedor)
    else
      render(conn, :show, fornecedor: fornecedor)
    end

  end

  def edit(conn, %{"id" => id}) do
    fornecedor = Estoque.get_fornecedor!(id)
    changeset = Estoque.change_fornecedor(fornecedor)
    render(conn, :edit, fornecedor: fornecedor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "fornecedor" => fornecedor_params}) do
    fornecedor = Estoque.get_fornecedor!(id)

    case Estoque.update_fornecedor(fornecedor, fornecedor_params) do
      {:ok, fornecedor} ->
        conn
        |> put_flash(:info, "Fornecedor updated successfully.")
        |> redirect(to: ~p"/fornecedores/#{fornecedor}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, fornecedor: fornecedor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    fornecedor = Estoque.get_fornecedor!(id)
    {:ok, _fornecedor} = Estoque.delete_fornecedor(fornecedor)

    conn
    |> put_flash(:info, "Fornecedor deleted successfully.")
    |> redirect(to: ~p"/fornecedores")
  end
end
