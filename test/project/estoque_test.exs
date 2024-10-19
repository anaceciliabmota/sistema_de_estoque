defmodule Project.EstoqueTest do
  use Project.DataCase

  alias Project.Estoque

  describe "produtos" do
    alias Project.Estoque.Produto

    import Project.EstoqueFixtures

    @invalid_attrs %{description: nil, name: nil, price: nil, quantity: nil}

    test "list_produtos/0 returns all produtos" do
      produto = produto_fixture()
      assert Estoque.list_produtos() == [produto]
    end

    test "get_produto!/1 returns the produto with given id" do
      produto = produto_fixture()
      assert Estoque.get_produto!(produto.id) == produto
    end

    test "create_produto/1 with valid data creates a produto" do
      valid_attrs = %{description: "some description", name: "some name", price: "120.5", quantity: 42}

      assert {:ok, %Produto{} = produto} = Estoque.create_produto(valid_attrs)
      assert produto.description == "some description"
      assert produto.name == "some name"
      assert produto.price == Decimal.new("120.5")
      assert produto.quantity == 42
    end

    test "create_produto/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Estoque.create_produto(@invalid_attrs)
    end

    test "update_produto/2 with valid data updates the produto" do
      produto = produto_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name", price: "456.7", quantity: 43}

      assert {:ok, %Produto{} = produto} = Estoque.update_produto(produto, update_attrs)
      assert produto.description == "some updated description"
      assert produto.name == "some updated name"
      assert produto.price == Decimal.new("456.7")
      assert produto.quantity == 43
    end

    test "update_produto/2 with invalid data returns error changeset" do
      produto = produto_fixture()
      assert {:error, %Ecto.Changeset{}} = Estoque.update_produto(produto, @invalid_attrs)
      assert produto == Estoque.get_produto!(produto.id)
    end

    test "delete_produto/1 deletes the produto" do
      produto = produto_fixture()
      assert {:ok, %Produto{}} = Estoque.delete_produto(produto)
      assert_raise Ecto.NoResultsError, fn -> Estoque.get_produto!(produto.id) end
    end

    test "change_produto/1 returns a produto changeset" do
      produto = produto_fixture()
      assert %Ecto.Changeset{} = Estoque.change_produto(produto)
    end
  end

  describe "fornecedores" do
    alias Project.Estoque.Fornecedor

    import Project.EstoqueFixtures

    @invalid_attrs %{address: nil, email: nil, name: nil, phone: nil}

    test "list_fornecedores/0 returns all fornecedores" do
      fornecedor = fornecedor_fixture()
      assert Estoque.list_fornecedores() == [fornecedor]
    end

    test "get_fornecedor!/1 returns the fornecedor with given id" do
      fornecedor = fornecedor_fixture()
      assert Estoque.get_fornecedor!(fornecedor.id) == fornecedor
    end

    test "create_fornecedor/1 with valid data creates a fornecedor" do
      valid_attrs = %{address: "some address", email: "some email", name: "some name", phone: "some phone"}

      assert {:ok, %Fornecedor{} = fornecedor} = Estoque.create_fornecedor(valid_attrs)
      assert fornecedor.address == "some address"
      assert fornecedor.email == "some email"
      assert fornecedor.name == "some name"
      assert fornecedor.phone == "some phone"
    end

    test "create_fornecedor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Estoque.create_fornecedor(@invalid_attrs)
    end

    test "update_fornecedor/2 with valid data updates the fornecedor" do
      fornecedor = fornecedor_fixture()
      update_attrs = %{address: "some updated address", email: "some updated email", name: "some updated name", phone: "some updated phone"}

      assert {:ok, %Fornecedor{} = fornecedor} = Estoque.update_fornecedor(fornecedor, update_attrs)
      assert fornecedor.address == "some updated address"
      assert fornecedor.email == "some updated email"
      assert fornecedor.name == "some updated name"
      assert fornecedor.phone == "some updated phone"
    end

    test "update_fornecedor/2 with invalid data returns error changeset" do
      fornecedor = fornecedor_fixture()
      assert {:error, %Ecto.Changeset{}} = Estoque.update_fornecedor(fornecedor, @invalid_attrs)
      assert fornecedor == Estoque.get_fornecedor!(fornecedor.id)
    end

    test "delete_fornecedor/1 deletes the fornecedor" do
      fornecedor = fornecedor_fixture()
      assert {:ok, %Fornecedor{}} = Estoque.delete_fornecedor(fornecedor)
      assert_raise Ecto.NoResultsError, fn -> Estoque.get_fornecedor!(fornecedor.id) end
    end

    test "change_fornecedor/1 returns a fornecedor changeset" do
      fornecedor = fornecedor_fixture()
      assert %Ecto.Changeset{} = Estoque.change_fornecedor(fornecedor)
    end
  end

  describe "movimentacoes" do
    alias Project.Estoque.Movimentacao

    import Project.EstoqueFixtures

    @invalid_attrs %{date: nil, movement_type: nil, quantity: nil, remarks: nil}

    test "list_movimentacoes/0 returns all movimentacoes" do
      movimentacao = movimentacao_fixture()
      assert Estoque.list_movimentacoes() == [movimentacao]
    end

    test "get_movimentacao!/1 returns the movimentacao with given id" do
      movimentacao = movimentacao_fixture()
      assert Estoque.get_movimentacao!(movimentacao.id) == movimentacao
    end

    test "create_movimentacao/1 with valid data creates a movimentacao" do
      valid_attrs = %{date: ~N[2024-10-18 11:45:00], movement_type: "some movement_type", quantity: 42, remarks: "some remarks"}

      assert {:ok, %Movimentacao{} = movimentacao} = Estoque.create_movimentacao(valid_attrs)
      assert movimentacao.date == ~N[2024-10-18 11:45:00]
      assert movimentacao.movement_type == "some movement_type"
      assert movimentacao.quantity == 42
      assert movimentacao.remarks == "some remarks"
    end

    test "create_movimentacao/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Estoque.create_movimentacao(@invalid_attrs)
    end

    test "update_movimentacao/2 with valid data updates the movimentacao" do
      movimentacao = movimentacao_fixture()
      update_attrs = %{date: ~N[2024-10-19 11:45:00], movement_type: "some updated movement_type", quantity: 43, remarks: "some updated remarks"}

      assert {:ok, %Movimentacao{} = movimentacao} = Estoque.update_movimentacao(movimentacao, update_attrs)
      assert movimentacao.date == ~N[2024-10-19 11:45:00]
      assert movimentacao.movement_type == "some updated movement_type"
      assert movimentacao.quantity == 43
      assert movimentacao.remarks == "some updated remarks"
    end

    test "update_movimentacao/2 with invalid data returns error changeset" do
      movimentacao = movimentacao_fixture()
      assert {:error, %Ecto.Changeset{}} = Estoque.update_movimentacao(movimentacao, @invalid_attrs)
      assert movimentacao == Estoque.get_movimentacao!(movimentacao.id)
    end

    test "delete_movimentacao/1 deletes the movimentacao" do
      movimentacao = movimentacao_fixture()
      assert {:ok, %Movimentacao{}} = Estoque.delete_movimentacao(movimentacao)
      assert_raise Ecto.NoResultsError, fn -> Estoque.get_movimentacao!(movimentacao.id) end
    end

    test "change_movimentacao/1 returns a movimentacao changeset" do
      movimentacao = movimentacao_fixture()
      assert %Ecto.Changeset{} = Estoque.change_movimentacao(movimentacao)
    end
  end
end
