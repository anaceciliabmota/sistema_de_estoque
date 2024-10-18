defmodule Project.Estoque do
  @moduledoc """
  The Estoque context.
  """

  import Ecto.Query, warn: false
  alias Project.Repo

  alias Project.Estoque.Produto

  @doc """
  Returns the list of produtos.

  ## Examples

      iex> list_produtos()
      [%Produto{}, ...]

  """
  def list_produtos do
    Repo.all(Produto)
  end

  @doc """
  Gets a single produto.

  Raises `Ecto.NoResultsError` if the Produto does not exist.

  ## Examples

      iex> get_produto!(123)
      %Produto{}

      iex> get_produto!(456)
      ** (Ecto.NoResultsError)

  """
  def get_produto!(id), do: Repo.get!(Produto, id)

  @doc """
  Creates a produto.

  ## Examples

      iex> create_produto(%{field: value})
      {:ok, %Produto{}}

      iex> create_produto(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_produto(attrs \\ %{}) do
    %Produto{}
    |> Produto.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a produto.

  ## Examples

      iex> update_produto(produto, %{field: new_value})
      {:ok, %Produto{}}

      iex> update_produto(produto, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_produto(%Produto{} = produto, attrs) do
    produto
    |> Produto.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a produto.

  ## Examples

      iex> delete_produto(produto)
      {:ok, %Produto{}}

      iex> delete_produto(produto)
      {:error, %Ecto.Changeset{}}

  """
  def delete_produto(%Produto{} = produto) do
    Repo.delete(produto)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking produto changes.

  ## Examples

      iex> change_produto(produto)
      %Ecto.Changeset{data: %Produto{}}

  """
  def change_produto(%Produto{} = produto, attrs \\ %{}) do
    Produto.changeset(produto, attrs)
  end

  alias Project.Estoque.Fornecedor

  @doc """
  Returns the list of fornecedores.

  ## Examples

      iex> list_fornecedores()
      [%Fornecedor{}, ...]

  """
  def list_fornecedores do
    Repo.all(Fornecedor)
  end

  @doc """
  Gets a single fornecedor.

  Raises `Ecto.NoResultsError` if the Fornecedor does not exist.

  ## Examples

      iex> get_fornecedor!(123)
      %Fornecedor{}

      iex> get_fornecedor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fornecedor!(id), do: Repo.get!(Fornecedor, id)

  @doc """
  Creates a fornecedor.

  ## Examples

      iex> create_fornecedor(%{field: value})
      {:ok, %Fornecedor{}}

      iex> create_fornecedor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fornecedor(attrs \\ %{}) do
    %Fornecedor{}
    |> Fornecedor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fornecedor.

  ## Examples

      iex> update_fornecedor(fornecedor, %{field: new_value})
      {:ok, %Fornecedor{}}

      iex> update_fornecedor(fornecedor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fornecedor(%Fornecedor{} = fornecedor, attrs) do
    fornecedor
    |> Fornecedor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fornecedor.

  ## Examples

      iex> delete_fornecedor(fornecedor)
      {:ok, %Fornecedor{}}

      iex> delete_fornecedor(fornecedor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fornecedor(%Fornecedor{} = fornecedor) do
    Repo.delete(fornecedor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fornecedor changes.

  ## Examples

      iex> change_fornecedor(fornecedor)
      %Ecto.Changeset{data: %Fornecedor{}}

  """
  def change_fornecedor(%Fornecedor{} = fornecedor, attrs \\ %{}) do
    Fornecedor.changeset(fornecedor, attrs)
  end
end
