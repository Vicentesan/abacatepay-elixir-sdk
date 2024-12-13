defmodule AbacatePay.Resources.Billing do
  @moduledoc """
  Handles billing-related operations with the Abacatepay API.
  """

  alias Abacatepay.Types.Client
  alias Abacatepay.Types.Billing
  require Logger

  @doc """
  Create a new billing
  """
  @spec create(Client.t(), Billing.create_data()) :: Billing.response()
  def create(client, params) do
    Logger.debug("Creating billing with params: #{inspect(params)}")

    case Client.post(client, "/billing/create", Jason.encode!(params)) do
      {:ok, response} ->
        Logger.debug("Received response: #{inspect(response)}")
        case response do
          %{status_code: 200, body: %{"data" => data}} ->
            billing = %Billing{
              id: data["id"],
              url: data["url"],
              amount: data["amount"],
              devMode: data["devMode"],
              status: String.to_atom(data["status"]),
              frequency: String.to_atom(data["frequency"]),
              metadata: data["metadata"],
              publicId: data["publicId"],
              createdAt: data["createdAt"],
              updatedAt: data["updatedAt"],
              methods: Enum.map(data["methods"], &String.to_atom/1),
              products: data["products"],
              customer: data["customer"],
              customerId: data["customerId"]
            }
            {:ok, billing}
          
          %{body: %{"error" => error}} ->
            Logger.error("Error creating billing: #{inspect(error)}")
            {:error, error}
          
          _ ->
            Logger.error("Unexpected response format: #{inspect(response)}")
            {:error, "Unexpected response format"}
        end

      {:error, error} ->
        Logger.error("Error posting billing: #{inspect(error)}")
        {:error, error.reason}
    end
  end

  @doc """
  List Billings
  """
  @spec list(Client.t()) :: Billing.list_response()
  def list(client) do
    Logger.debug("Listing billings")

    case Client.get(client, "/billing/list") do
      {:ok, response} ->
        Logger.debug("Received response: #{inspect(response)}")
        case response do
          %{status_code: 200, body: %{"data" => data}} ->
            billings = Enum.map(data, fn billing_data ->
              %Billing{
                id: billing_data["id"],
                url: billing_data["url"],
                amount: billing_data["amount"],
                devMode: billing_data["devMode"],
                status: String.to_atom(billing_data["status"]),
                frequency: String.to_atom(billing_data["frequency"]),
                metadata: billing_data["metadata"],
                publicId: billing_data["publicId"],
                createdAt: billing_data["createdAt"],
                updatedAt: billing_data["updatedAt"],
                methods: Enum.map(billing_data["methods"], &String.to_atom/1),
                products: billing_data["products"],
                customer: billing_data["customer"],
                customerId: billing_data["customerId"]
              }
            end)
            {:ok, billings}
          
          %{body: %{"error" => error}} ->
            Logger.error("Error listing billings: #{inspect(error)}")
            {:error, error}
          
          _ ->
            Logger.error("Unexpected response format: #{inspect(response)}")
            {:error, "Unexpected response format"}
        end

      {:error, error} ->
        Logger.error("Error getting billings: #{inspect(error)}")
        {:error, error.reason}
    end
  end
end