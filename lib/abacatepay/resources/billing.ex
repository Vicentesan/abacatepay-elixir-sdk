defmodule Abacatepay.Billing do
  alias Abacatepay.Client
  alias Abacatepay.Types.Billing

  @doc """
  Create a new billing
  """
  @spec create(Client.t(), Billing.create_data()) :: Billing.response()
  def create(client, params) do
    case Client.post(client, "/billing/create", Jason.encode!(params)) do
      { :ok, %{ status_code: 200, body: body } } ->
        { :ok, struct(Billing, body) }

      { :ok, %{ status_code: 401, body: %{"error" => error} } } ->
        { :error, error }

      { :ok, %{ status_code: _, body: %{"error" => error} } } ->
        { :error, error }

      { :error, error } ->
        { :error, error.reason }
    end
  end

  @doc """
  Get a billing by ID
  """
  @spec list(Client.t()) :: Billing.list_response()
  def list(client) do
    case Client.get(client, "/billing/list") do
      { :ok, %{ status_code: 200, body: body } } ->
        { :ok, struct(Billing, body) }

      { :ok, %{ status_code: 401, body: %{"error" => error} } } ->
        { :error, error }

      { :ok, %{ status_code: _, body: %{"error" => error} } } ->
        { :error, error }

      { :error, error } ->
        { :error, error.reason }
    end
  end
end