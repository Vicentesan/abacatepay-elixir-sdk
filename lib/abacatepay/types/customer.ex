defmodule Abacatepay.Types.Customer do
  @moduledoc """
  Customer-related type definitions that match the API structures.
  """

  @type metadata :: %{
    name: String.t(),
    cellphone: String.t(),
    taxId: String.t(),
    email: String.t()
  }

  @type id :: %{
    metadata: metadata(),
    id: String.t(),
    publicId: String.t(),
    storeId: String.t(),
    devMode: boolean,
    createdAt: DateTime.t(),
    updatedAt: DateTime.t(),
    version: integer
  }

  @type t :: %{
    id: String.t(),
    metadata: metadata()
  }

  @type response ::
    {:ok, t()} |
    {:error, String.t()}

  defstruct [:id, :metadata]
end 