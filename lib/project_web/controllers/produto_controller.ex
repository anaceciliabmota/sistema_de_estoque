defmodule ProjectWeb.ProdutoController do
  use ProjectWeb, :controller

  alias Project.Estoque
  alias Project.Estoque.Produto

  def index(conn, _params) do
    produtos = Estoque.list_produtos()
    |> Project.Repo.preload(:fornecedor)
    render(conn, :index, produtos: produtos)
  end

  def new(conn, _params) do
    changeset = Estoque.change_produto(%Produto{})
    fornecedores = Estoque.list_fornecedores()
      |> Enum.map(fn fornecedor -> {fornecedor.name, fornecedor.id} end)
    render(conn, :new, changeset: changeset, fornecedores: fornecedores)
  end

  def create(conn, %{"produto" => produto_params}) do
    case Estoque.create_produto(produto_params) do
      {:ok, produto} ->
        conn
        |> put_flash(:info, "Produto created successfully.")
        |> redirect(to: ~p"/produtos/#{produto}")

      {:error, %Ecto.Changeset{} = changeset} ->
        fornecedores = Estoque.list_fornecedores()
          |> Enum.map(fn fornecedor -> {fornecedor.name, fornecedor.id} end)
        render(conn, :new, changeset: changeset, fornecedores: fornecedores)
    end
  end

  def show(conn, %{"id" => id}) do
    produto = Estoque.get_produto!(id)
    |> Project.Repo.preload(:fornecedor)
    render(conn, :show, produto: produto)
  end

  def edit(conn, %{"id" => id}) do
    produto = Estoque.get_produto!(id)
    changeset = Estoque.change_produto(produto)
    render(conn, :edit, produto: produto, changeset: changeset)
  end

  def update(conn, %{"id" => id, "produto" => produto_params}) do
    produto = Estoque.get_produto!(id)

    case Estoque.update_produto(produto, produto_params) do
      {:ok, produto} ->
        conn
        |> put_flash(:info, "Produto updated successfully.")
        |> redirect(to: ~p"/produtos/#{produto}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, produto: produto, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    produto = Estoque.get_produto!(id)
    {:ok, _produto} = Estoque.delete_produto(produto)

    conn
    |> put_flash(:info, "Produto deleted successfully.")
    |> redirect(to: ~p"/produtos")
  end
end
