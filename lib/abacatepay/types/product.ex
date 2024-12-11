defmodule Abacatepay.Types.Product do
  @type t :: %{
    productId: String.t(),
    quantity: integer
  }

  @type create_data :: %{
    externalId: String.t(),
    name: String.t(),
    quantity: integer,
    price: float,
    description: String.t() | nil
  }
end 