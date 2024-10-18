defmodule ProjectWeb.ProdutoControllerTest do
  use ProjectWeb.ConnCase

  import Project.EstoqueFixtures

  @create_attrs %{description: "some description", name: "some name", price: "120.5", quantity: 42}
  @update_attrs %{description: "some updated description", name: "some updated name", price: "456.7", quantity: 43}
  @invalid_attrs %{description: nil, name: nil, price: nil, quantity: nil}

  describe "index" do
    test "lists all produtos", %{conn: conn} do
      conn = get(conn, ~p"/produtos")
      assert html_response(conn, 200) =~ "Listing Produtos"
    end
  end

  describe "new produto" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/produtos/new")
      assert html_response(conn, 200) =~ "New Produto"
    end
  end

  describe "create produto" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/produtos", produto: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/produtos/#{id}"

      conn = get(conn, ~p"/produtos/#{id}")
      assert html_response(conn, 200) =~ "Produto #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/produtos", produto: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Produto"
    end
  end

  describe "edit produto" do
    setup [:create_produto]

    test "renders form for editing chosen produto", %{conn: conn, produto: produto} do
      conn = get(conn, ~p"/produtos/#{produto}/edit")
      assert html_response(conn, 200) =~ "Edit Produto"
    end
  end

  describe "update produto" do
    setup [:create_produto]

    test "redirects when data is valid", %{conn: conn, produto: produto} do
      conn = put(conn, ~p"/produtos/#{produto}", produto: @update_attrs)
      assert redirected_to(conn) == ~p"/produtos/#{produto}"

      conn = get(conn, ~p"/produtos/#{produto}")
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, produto: produto} do
      conn = put(conn, ~p"/produtos/#{produto}", produto: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Produto"
    end
  end

  describe "delete produto" do
    setup [:create_produto]

    test "deletes chosen produto", %{conn: conn, produto: produto} do
      conn = delete(conn, ~p"/produtos/#{produto}")
      assert redirected_to(conn) == ~p"/produtos"

      assert_error_sent 404, fn ->
        get(conn, ~p"/produtos/#{produto}")
      end
    end
  end

  defp create_produto(_) do
    produto = produto_fixture()
    %{produto: produto}
  end
end
