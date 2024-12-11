defmodule Abacatepay.Types.Billing do
  alias Abacatepay.Types.Product
  alias Abacatepay.Types.Customer
  @type status :: :pending | :expired | :cancelled | :paid | :refunded
  @type method :: :pix
  @type kind :: :one_time
  
  @type t :: %{
    metadata: metadata(),
    id: String.t(),
    public_id: String.t(),
    products: list(Product.t()),
    amount: integer,
    status: status(),
    dev_mode: boolean,
    methods: list(method()),
    frequency: kind(),
    created_at: DateTime.t(),
    updated_at: DateTime.t(),
    url: String.t(),
    customer_id: Customer.id() | nil,
    customer: Customer.t() | nil
  }

  @type metadata :: %{
    fee: integer,
    return_url: String.t(),
    completion_url: String.t()
  }

  @type create_data :: %{
    frequency: kind(),
    methods: list(method()),
    products: list(Product.create_data()),
    return_url: String.t(),
    completion_url: String.t()
  }

  @type response ::
    {:ok, t()} |
    {:error, String.t()}

  @type list_response ::
    {:ok, list(t())} |
    {:error, String.t()}
end 