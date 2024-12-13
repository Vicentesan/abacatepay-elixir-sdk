# AbacatePay SDK

<!-- [![Hex.pm](https://img.shields.io/hexpm/v/abacate_pay.svg)](https://hex.pm/packages/abacate_pay) -->
<!-- [![Documentation](https://img.shields.io/badge/documentation-gray)](https://hexdocs.pm/abacate_pay) -->

Elixir SDK for integrating with AbacatePay's payment services.

## Installation

<!-- Add `abacate_pay` to your list of dependencies in `mix.exs`:  -->
Not available yet.

## Features

### Customer Operations

#### Create Customer
Create a new customer in the AbacatePay system.

```elixir
  customer_data = %{
  name: "John Doe",
  taxId: "123.456.789-00",
  email: "john@example.com",
  cellphone: "+5511999999999"
  }
  
  {:ok, customer} = AbacatePay.Resources.Customer.create(client, customer_data)
```

#### List Customers
Retrieve a list of all customers.

```elixir
{:ok, customers} = AbacatePay.Resources.Customer.list(client)
```


### Billing Operations

#### Create Billing
Create a new billing for a customer.

```elixir
billing_data = %{
  amount: 1000, # Amount in cents
  customerId: "cust_123", # Customer ID
  methods: ["pix", "credit_card"],
  products: [
    %{
    name: "Product Name",
    amount: 1000,
    quantity: 1
    }
  ]
}

{:ok, billing} = AbacatePay.Resources.Billing.create(client, billing_data)
```

#### List Billings
Retrieve a list of all billings.

```elixir
{:ok, billings} = AbacatePay.Resources.Billing.list(client)
```

### Response Types

#### Customer Response

```elixir
%Customer{
  id: "cust_123",
  metadata: %{
    name: "John Doe",
    taxId: "123.456.789-00",
    email: "john@example.com",
    cellphone: "+5511999999999"
  }
}
```

#### Billing Response

```elixir
%Billing{
  id: "bill_123",
  url: "https://pay.abacatepay.com/...",
  amount: 1000,
  devMode: false,
  status: :pending,
  frequency: :one_time,
  metadata: %{},
  publicId: "pub_123",
  createdAt: "2024-03-20T...",
  updatedAt: "2024-03-20T...",
  methods: [:pix, :credit_card],
  products: [
    %{
    name: "Product Name",
    amount: 1000,
    quantity: 1
    }
  ],
  customer: %{...},
  customerId: "cust_123"
}
```