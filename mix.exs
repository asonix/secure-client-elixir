defmodule SecureClient.Mixfile do
  use Mix.Project

  def project do
    [app: :secure_client,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:http_client]]
  end

  def description do
    """
    A secure encoder and decoder for HTTPClient.
    """
  end

  def package do
    [name: :http_client,
     maintainers: ["Riley Trautman", "asonix.dev@gmail.com"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/asonix/secure-client-elixir"}]
  end

  defp deps do
    [{:http_client, "~> 0.1"},
     {:cloak, "~> 0.2"},
     {:bypass, "~> 0.1", only: :test},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end
end
