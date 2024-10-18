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
end
