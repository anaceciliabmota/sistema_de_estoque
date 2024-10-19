defmodule ProjectWeb.MovimentacaoControllerTest do
  use ProjectWeb.ConnCase

  import Project.EstoqueFixtures

  @create_attrs %{date: ~N[2024-10-18 11:45:00], movement_type: "some movement_type", quantity: 42, remarks: "some remarks"}
  @update_attrs %{date: ~N[2024-10-19 11:45:00], movement_type: "some updated movement_type", quantity: 43, remarks: "some updated remarks"}
  @invalid_attrs %{date: nil, movement_type: nil, quantity: nil, remarks: nil}

  describe "index" do
    test "lists all movimentacoes", %{conn: conn} do
      conn = get(conn, ~p"/movimentacoes")
      assert html_response(conn, 200) =~ "Listing Movimentacoes"
    end
  end

  describe "new movimentacao" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/movimentacoes/new")
      assert html_response(conn, 200) =~ "New Movimentacao"
    end
  end

  describe "create movimentacao" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/movimentacoes", movimentacao: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/movimentacoes/#{id}"

      conn = get(conn, ~p"/movimentacoes/#{id}")
      assert html_response(conn, 200) =~ "Movimentacao #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/movimentacoes", movimentacao: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Movimentacao"
    end
  end

  describe "edit movimentacao" do
    setup [:create_movimentacao]

    test "renders form for editing chosen movimentacao", %{conn: conn, movimentacao: movimentacao} do
      conn = get(conn, ~p"/movimentacoes/#{movimentacao}/edit")
      assert html_response(conn, 200) =~ "Edit Movimentacao"
    end
  end

  describe "update movimentacao" do
    setup [:create_movimentacao]

    test "redirects when data is valid", %{conn: conn, movimentacao: movimentacao} do
      conn = put(conn, ~p"/movimentacoes/#{movimentacao}", movimentacao: @update_attrs)
      assert redirected_to(conn) == ~p"/movimentacoes/#{movimentacao}"

      conn = get(conn, ~p"/movimentacoes/#{movimentacao}")
      assert html_response(conn, 200) =~ "some updated movement_type"
    end

    test "renders errors when data is invalid", %{conn: conn, movimentacao: movimentacao} do
      conn = put(conn, ~p"/movimentacoes/#{movimentacao}", movimentacao: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Movimentacao"
    end
  end

  describe "delete movimentacao" do
    setup [:create_movimentacao]

    test "deletes chosen movimentacao", %{conn: conn, movimentacao: movimentacao} do
      conn = delete(conn, ~p"/movimentacoes/#{movimentacao}")
      assert redirected_to(conn) == ~p"/movimentacoes"

      assert_error_sent 404, fn ->
        get(conn, ~p"/movimentacoes/#{movimentacao}")
      end
    end
  end

  defp create_movimentacao(_) do
    movimentacao = movimentacao_fixture()
    %{movimentacao: movimentacao}
  end
end
