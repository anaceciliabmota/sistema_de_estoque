defmodule ProjectWeb.ProdutoController do
  use ProjectWeb, :controller

  alias Project.Estoque
  alias Project.Estoque.Produto

  def index(conn, _params) do
    produtos = Estoque.list_produtos()
    |> Project.Repo.preload(:fornecedor)

    produtos_com_alerta = Enum.filter(produtos, fn produto ->
      produto.quantity < produto.min_quantity
    end)

    nomes_produtos_baixo_estoque = Enum.map(produtos_com_alerta, fn produto -> produto.name end)

    conn =
      if produtos_com_alerta != [] do
        mensagem_alerta = """
        <strong>Atenção: Os seguintes produtos estão com estoque baixo:</strong>
        <ul>
        #{Enum.map(nomes_produtos_baixo_estoque, fn nome -> "<li> - #{nome}</li>" end) |> Enum.join("\n")}
        </ul>
        """
        put_flash(conn, :error, {:safe, mensagem_alerta})
      else
        conn
      end

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
        |> put_flash(:info, "Produto criado com sucesso.")
        |> redirect(to: ~p"/produtos/#{produto}")

      {:error, %Ecto.Changeset{} = changeset} ->
        fornecedores = Estoque.list_fornecedores()
          |> Enum.map(fn fornecedor -> {fornecedor.name, fornecedor.id} end)

        if changeset.errors[:name] do
          conn
          |> put_flash(:error, "Erro: Já existe um produto com esse nome. Escolha outro nome.")
          |> render(:new, changeset: changeset, fornecedores: fornecedores)
        else
          render(conn, :new, changeset: changeset, fornecedores: fornecedores)
        end
    end
  end



  def show(conn, %{"id" => id} = params) do
    produto = Estoque.get_produto!(id)
    |> Project.Repo.preload(:fornecedor)

    source = Map.get(params, "source")

    if source == "estoque_baixo" do
      render(conn, :show_from_movimentacao, produto: produto)
    else
      render(conn, :show, produto: produto)
    end
  end

  def edit(conn, %{"id" => id}) do
    produto = Estoque.get_produto!(id)
    changeset = Estoque.change_produto(produto)
    fornecedores = Estoque.list_fornecedores()
    |> Enum.map(fn fornecedor -> {fornecedor.name, fornecedor.id} end)

    render(conn, :edit, produto: produto, changeset: changeset, fornecedores: fornecedores)
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
