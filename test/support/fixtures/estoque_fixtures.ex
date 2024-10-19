defmodule Project.EstoqueFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Project.Estoque` context.
  """

  @doc """
  Generate a produto.
  """
  def produto_fixture(attrs \\ %{}) do
    {:ok, produto} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        price: "120.5",
        quantity: 42
      })
      |> Project.Estoque.create_produto()

    produto
  end

  @doc """
  Generate a fornecedor.
  """
  def fornecedor_fixture(attrs \\ %{}) do
    {:ok, fornecedor} =
      attrs
      |> Enum.into(%{
        address: "some address",
        email: "some email",
        name: "some name",
        phone: "some phone"
      })
      |> Project.Estoque.create_fornecedor()

    fornecedor
  end

  @doc """
  Generate a movimentacao.
  """
  def movimentacao_fixture(attrs \\ %{}) do
    {:ok, movimentacao} =
      attrs
      |> Enum.into(%{
        date: ~N[2024-10-18 11:45:00],
        movement_type: "some movement_type",
        quantity: 42,
        remarks: "some remarks"
      })
      |> Project.Estoque.create_movimentacao()

    movimentacao
  end
end
