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
    produto_id = movimentacao_params["produto_id"]
    quantidade_movimentacao = String.to_integer(movimentacao_params["quantity"])
    movimento_tipo = movimentacao_params["movement_type"]

    produto = Estoque.get_produto!(produto_id)

    # Cálculo da nova quantidade de estoque com base no tipo de movimentação
    quantidade_ajustada =
      case movimento_tipo do
        "entrada" -> produto.quantity + quantidade_movimentacao
        "saida" -> produto.quantity - quantidade_movimentacao
      end

    # Verificar se a movimentação resultará em estoque negativo
    if quantidade_ajustada < 0 do
      conn
      |> put_flash(:error, "Erro: Não há estoque suficiente para esta movimentação!")
      |> redirect(to: ~p"/movimentacoes/new")
    else
      # A verificação de estoque passou, permitir criação
      movimentacao_params = Map.put(movimentacao_params, "date", NaiveDateTime.utc_now())

      case Estoque.create_movimentacao(movimentacao_params) do
        {:ok, movimentacao} ->
          # Atualizar o estoque do produto
          produto
          |> Estoque.update_produto(%{quantity: quantidade_ajustada})

          conn
          |> put_flash(:info, "Movimentação criada com sucesso!")
          |> redirect(to: ~p"/movimentacoes/#{movimentacao}")

        {:error, %Ecto.Changeset{} = changeset} ->
          produtos = Estoque.list_produtos()
            |> Enum.map(fn produto -> {produto.name, produto.id} end)
          render(conn, :new, changeset: changeset, produtos: produtos)
      end
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
    movimentacao_antiga = Estoque.get_movimentacao!(id)
    produto = Estoque.get_produto!(movimentacao_antiga.produto_id)

    quantidade_antiga =
      case movimentacao_antiga.movement_type do
        "entrada" -> produto.quantity - movimentacao_antiga.quantity
        "saida" -> produto.quantity + movimentacao_antiga.quantity
      end

    quantidade_nova = String.to_integer(movimentacao_params["quantity"])
    movimento_tipo_novo = movimentacao_params["movement_type"]

    quantidade_ajustada =
      case movimento_tipo_novo do
        "entrada" -> quantidade_antiga + quantidade_nova
        "saida" -> quantidade_antiga - quantidade_nova
      end

    #Tratamento de erro: Verificar se a movimentação resultará em estoque negativo
    if quantidade_ajustada < 0 do
      #Caso o estoque fique negativo, impedir a atualização
      conn
      |> put_flash(:error, "Edição proibída: Não havia estoque suficiente para esta edição de movimentação! Verifique a quantidade.")
      |> redirect(to: ~p"/movimentacoes/#{movimentacao_antiga}/edit")
    else
      #Caso o estoque seja suficiente, permitir a atualização
      case Estoque.update_movimentacao(movimentacao_antiga, movimentacao_params) do
        {:ok, movimentacao} ->
          produto
          |> Estoque.update_produto(%{quantity: quantidade_ajustada})

          conn
          |> put_flash(:info, "Movimentação atualizada com sucesso.")
          |> redirect(to: ~p"/movimentacoes/#{movimentacao}")

        {:error, %Ecto.Changeset{} = changeset} ->
          produtos = Estoque.list_produtos()
            |> Enum.map(fn produto -> {produto.name, produto.id} end)
          render(conn, :edit, movimentacao: movimentacao_antiga, changeset: changeset, produtos: produtos)
      end
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
