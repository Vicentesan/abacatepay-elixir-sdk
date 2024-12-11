defmodule AbacatePay.MixProject do
  use Mix.Project

  @version "0.0.0"
  @source_url "https://github.com/vicentesan/abacatepay-elixir-sdk"

  def project do
    [
      app: :abacate_pay,
      version: @version,
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs(),
      name: "AbacatePay",
      source_url: @source_url
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.4"},
      {:httpoison, "~> 2.0"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    """
    AbacatePay SDK - A payment processing library for integrating with AbacatePay's payment services.
    """
  end

  defp package do
    [
      name: "abacate_pay",
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url,
        "Changelog" => "#{@source_url}/blob/master/CHANGELOG.md"
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      # canonical: "http://hexdocs.pm/abacate_pay",
      extras: ["README.md", "CHANGELOG.md"],
      groups_for_modules: [
        "Resources": [
          AbacatePay.Resources.Customer,
          AbacatePay.Resources.Customers,
          AbacatePay.Resources.Billing
        ],
        "Types": [
          AbacatePay.Types.Customer,
          AbacatePay.Types.Billing,
          AbacatePay.Types.Product
        ]
      ]
    ]
  end
end 