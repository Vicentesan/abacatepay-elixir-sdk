defmodule AbacatePay.Resources.Customer do
  @moduledoc """
  Handles customer-related operations with the Abacatepay API.

  ## Examples

      client = Abacatepay.Client.new("your_api_key")
      
      # Create a customer
      customer_data = %{
        name: "John Doe",
        taxId: "123.456.789-00", 
        email: "john@example.com",
        cellphone: "+5511999999999"
      }

      { :ok, customer } = Abacatepay.Customer.create(client, customer_data)
  """

  alias Abacatepay.Types.Client
  alias Abacatepay.Types.Customer
  require Logger

  @doc """
  Create a new customer
  """
  @spec create(Client.t(), Customer.metadata()) :: Customer.response()
  def create(client, params) do
    case Client.post(client, "/customer/create", Jason.encode!(params)) do
      {:ok, response} ->
        Logger.info("Response received: #{inspect(response, pretty: true)}")
        
        case response do
          %{status_code: 200, body: %{"data" => data}} ->
            customer = %Customer{
              id: data["id"],
              metadata: data["metadata"]
            }
            {:ok, customer}
          
          %{body: %{"error" => error}} ->
            {:error, error}
          
          _ ->
            Logger.error("Unexpected response format: #{inspect(response, pretty: true)}")
            {:error, "Unexpected response format"}
        end

      {:error, error} ->
        Logger.error("Request error: #{inspect(error, pretty: true)}")
        {:error, error.reason}
    end
  end

  @doc """
  List Customers
  """
  @spec list(Client.t()) :: Customer.list_response()
  def list(client) do
    case Client.get(client, "/customer/list") do
      {:ok, response} ->
        case response do
          %{status_code: 200, body: %{"data" => data}} ->
            customers = Enum.map(data, fn customer_data ->
              %Customer{
                id: customer_data["id"],
                metadata: customer_data["metadata"]
              }
            end)
            {:ok, customers}
          
          %{body: %{"error" => error}} ->
            {:error, error}
          
          _ ->
            {:error, "Unexpected response format"}
        end

      {:error, error} ->
        {:error, error.reason}
    end
  end
end