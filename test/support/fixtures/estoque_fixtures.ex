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
end
