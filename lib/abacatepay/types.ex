defmodule Abacatepay.Types do
  @moduledoc """
  Defines the core types used throughout the Abacatepay SDK.
  """

  @typedoc "Status of a billing transaction"
  @type billing_status :: :pending | :expired | :cancelled | :paid | :refunded

  @typedoc "Payment method for billing"
  @type billing_method :: :pix

  @typedoc "Type of billing frequency"
  @type billing_kind :: :one_time

  @typedoc "Metadata containing fee and URL information"
  @type metadata :: %{
    fee: integer,
    return_url: String.t(),
    completion_url: String.t()
  }

  @typedoc "Product information"
  @type product :: %{
    product_id: String.t(),
    quantity: integer
  }

  @typedoc "Customer metadata containing personal information"
  @type customer_metadata :: %{
    name: String.t(),
    cellphone: String.t(),
    tax_id: String.t(),
    email: String.t()
  }

  @typedoc "Customer identification information"
  @type customer_id :: %{
    metadata: customer_metadata,
    id: String.t(),
    public_id: String.t(),
    store_id: String.t(),
    dev_mode: boolean,
    created_at: DateTime.t(),
    updated_at: DateTime.t()
  }

  @typedoc "Basic customer information"
  @type customer :: %{
    id: String.t(),
    metadata: customer_metadata
  }

  @typedoc "Complete billing information"
  @type billing :: %{
    metadata: metadata,
    id: String.t(),
    public_id: String.t(),
    products: list(product),
    amount: integer,
    status: billing_status,
    dev_mode: boolean,
    methods: list(billing_method),
    frequency: billing_kind,
    created_at: DateTime.t(),
    updated_at: DateTime.t(),
    url: String.t(),
    customer_id: customer_id | nil,
    customer: customer | nil
  }

  @typedoc "Product information for creating a billing"
  @type create_billing_product :: %{
    external_id: String.t(),
    name: String.t(),
    quantity: integer,
    price: float,
    description: String.t() | nil
  }

  @typedoc "Data required to create a billing"
  @type create_billing_data :: %{
    frequency: billing_kind,
    methods: list(billing_method),
    products: list(create_billing_product),
    return_url: String.t(),
    completion_url: String.t()
  }

  @typedoc "Response from creating a billing"
  @type create_billing_response ::
    {:ok, billing} |
    {:error, String.t()}

  @typedoc "Response from listing billings"
  @type list_billing_response ::
    {:ok, list(billing)} |
    {:error, String.t()}
end
