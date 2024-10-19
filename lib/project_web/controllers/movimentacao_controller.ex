defmodule ProjectWeb.MovimentacaoController do
  use ProjectWeb, :controller

  alias Project.Estoque
  alias Project.Repo
  alias Project.Estoque.Movimentacao
  alias Project.Estoque.Produto

  def index(conn, _params) do
    movimentacoes = Estoque.list_movimentacoes()
    |> Project.Repo.preload(:produto)
    render(conn, :index, movimentacoes: movimentacoes)
  end

  def new(conn, _params) do
    changeset = Estoque.change_movimentacao(%Movimentacao{})
    produtos = Estoque.list_produtos()
      |> Enum.map(fn produto -> {produto.name, produto.id} end)
    render(conn, :new, changeset: changeset, produtos: produtos)
  end

  def create(conn, %{"movimentacao" => movimentacao_params}) do
    movimentacao_params = Map.put(movimentacao_params, "date", NaiveDateTime.utc_now())

    case Estoque.create_movimentacao(movimentacao_params) do
      {:ok, movimentacao} ->
        case processar_movimentacao(movimentacao) do
          {:ok, _produto} ->
            conn
            |> put_flash(:info, "Movimentação criada com sucesso!")
            |> redirect(to: ~p"/movimentacoes/#{movimentacao}")
          end
      {:error, %Ecto.Changeset{} = changeset} ->
        produtos = Estoque.list_produtos()
          |> Enum.map(fn produto -> {produto.name, produto.id} end)
        render(conn, :new, changeset: changeset, produtos: produtos)
    end
  end

  def show(conn, %{"id" => id}) do
    movimentacao = Estoque.get_movimentacao!(id)
    |> Project.Repo.preload(:produto)
    render(conn, :show, movimentacao: movimentacao)
  end

  def edit(conn, %{"id" => id}) do
    movimentacao = Estoque.get_movimentacao!(id)
    changeset = Estoque.change_movimentacao(movimentacao)
    render(conn, :edit, movimentacao: movimentacao, changeset: changeset)
  end

  def update(conn, %{"id" => id, "movimentacao" => movimentacao_params}) do
    movimentacao = Estoque.get_movimentacao!(id)

    case Estoque.update_movimentacao(movimentacao, movimentacao_params) do
      {:ok, movimentacao} ->
        conn
        |> put_flash(:info, "Movimentacao updated successfully.")
        |> redirect(to: ~p"/movimentacoes/#{movimentacao}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, movimentacao: movimentacao, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    movimentacao = Estoque.get_movimentacao!(id)
    {:ok, _movimentacao} = Estoque.delete_movimentacao(movimentacao)

    conn
    |> put_flash(:info, "Movimentacao deleted successfully.")
    |> redirect(to: ~p"/movimentacoes")
  end

  defp processar_movimentacao(%Movimentacao{} = movimentacao) do
    produto = Repo.get!(Produto, movimentacao.produto_id)

    nova_quantidade =
      case movimentacao.movement_type do
        "entrada" -> produto.quantity + movimentacao.quantity
        "saida" -> produto.quantity - movimentacao.quantity
      end

      Project.Estoque.update_produto(produto, %{quantity: nova_quantidade})
  end
end
