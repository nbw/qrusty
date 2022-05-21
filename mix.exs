defmodule Qrusty.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/nbw/qrusty"

  def project do
    [
      app: :qrusty,
      version: @version,
      github: @source_url,
      elixir: "~> 1.12",
      aliases: aliases(),
      start_permanent: Mix.env() == :prod,
      docs: docs(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:rustler_precompiled, "~> 0.4"},
      {:rustler, ">= 0.25.0", optional: true},

      # docs
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},

      # benchmarking
      {:benchee, "~> 1.0", only: :dev},
      {:benchee_html, "~> 1.0", only: :dev},
      {:eqrcode, "~> 0.1.10", only: :dev}
    ]
  end

  defp docs do
    [
      main: "QRusty",
      assets: "assets",
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end

  defp aliases do
    [
      "compile.local": &compile_local/1
    ]
  end

  defp compile_local(_) do
    Mix.shell().cmd("QRUSTY_BUILD=true mix compile")
  end
end
