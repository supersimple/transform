defmodule Transform.MixProject do
  use Mix.Project

  def project do
    [
      app: :transform,
      version: "0.1.0",
      elixir: "~> 1.13",
      escript: escript_config(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp escript_config do
    [main_module: Transform, name: "transform", comment: "Transforms colors"]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:chameleon, "~> 2.4.0"}
    ]
  end
end
