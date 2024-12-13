defmodule Abacatepay.Types.Client do
  @moduledoc """
  HTTP client for making requests to the Abacatepay API.
  """

  use HTTPoison.Base

  @base_url "https://api.abacatepay.com/v1"

  defstruct [:api_key]

  @type t :: %__MODULE__{api_key: String.t()}

  @spec new(String.t()) :: t()
  def new(api_key) do
    %__MODULE__{api_key: api_key}
  end

  @spec process_url(String.t()) :: String.t()
  def process_url(url) do
    @base_url <> url
  end

  def process_request_headers(%{api_key: api_key}, headers) do
    [
      { "Content-Type", "application/json" },
      { "Accept", "application/json" },
      { "User-Agent", "Abacatepay-Elixir/#{Application.spec(:abacatepay, :vsn)}" },
      { "Authorization", "Bearer #{api_key}" }
      | headers
    ]
  end

  def post(%__MODULE__{} = client, url, body, headers \\ [], options \\ []) do
    request(client, :post, url, body, headers, options)
    |> handle_response()
  end

  def get(%__MODULE__{} = client, url, headers \\ [], options \\ []) do
    request(client, :get, url, "", headers, options)
    |> handle_response()
  end

  defp request(%__MODULE__{} = client, method, url, body, headers, options) do
    headers = process_request_headers(client, headers)
    url = process_url(url)
    HTTPoison.request(method, url, body, headers, options)
  end

  defp handle_response({:ok, %{body: body} = response}) do
    decoded_body = Jason.decode!(body)
    {:ok, %{response | body: decoded_body}}
  end
  
  defp handle_response(error), do: error
end