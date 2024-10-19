defmodule ProjectWeb.MovimentacaoController do
  use ProjectWeb, :controller

  alias Project.Estoque
  alias Project.Repo
  alias Project.Estoque.Movimentacao

  def index(conn, _params) do
    movimentacoes = Estoque.list_movimentacoes()
      |> Repo.preload(:produto)
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
        conn
        |> put_flash(:info, "Movimentação criada com sucesso!")
        |> redirect(to: ~p"/movimentacoes/#{movimentacao}")

      {:error, %Ecto.Changeset{} = changeset} ->
        produtos = Estoque.list_produtos()
          |> Enum.map(fn produto -> {produto.name, produto.id} end)
        render(conn, :new, changeset: changeset, produtos: produtos)
    end
  end

  def show(conn, %{"id" => id}) do
    movimentacao = Estoque.get_movimentacao!(id)
      |> Repo.preload(:produto)
    render(conn, :show, movimentacao: movimentacao)
  end

  def edit(conn, %{"id" => id}) do
    movimentacao = Estoque.get_movimentacao!(id)
    changeset = Estoque.change_movimentacao(movimentacao)

    produtos = Estoque.list_produtos()
      |> Enum.map(fn produto -> {produto.name, produto.id} end)

    render(conn, :edit, movimentacao: movimentacao, changeset: changeset, produtos: produtos)
  end

  def update(conn, %{"id" => id, "movimentacao" => movimentacao_params}) do
    movimentacao = Estoque.get_movimentacao!(id)

    case Estoque.update_movimentacao(movimentacao, movimentacao_params) do
      {:ok, movimentacao} ->
        conn
        |> put_flash(:info, "Movimentação atualizada com sucesso.")
        |> redirect(to: ~p"/movimentacoes/#{movimentacao}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, movimentacao: movimentacao, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    movimentacao = Estoque.get_movimentacao!(id)
    {:ok, _movimentacao} = Estoque.delete_movimentacao(movimentacao)

    conn
    |> put_flash(:info, "Movimentação excluída com sucesso.")
    |> redirect(to: ~p"/movimentacoes")
  end
end
