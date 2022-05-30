defmodule Qrusty.Native.Options do
  defstruct format: :svg,
            width: 200,
            height: 200,
            error_correction: :m
end

defmodule Qrusty.Native do
  @moduledoc """
  Generates QR Codes by executing a Rust NIF.

  As a general rule, fuctions in this module should no
  be called directly. Instead, refer to the `Qrusty` module.
  """
  version = Mix.Project.config()[:version]
  host = Mix.Project.config()[:github]

  use RustlerPrecompiled,
    otp_app: :qrusty,
    crate: "qrusty",
    base_url: "#{host}/releases/download/v#{version}",
    force_build: System.get_env("QRUSTY_BUILD") in ["1", "true"],
    version: version

  alias Qrusty.Native.Options

  @doc false
  def generate(data, :svg, w, h, ec) do
    opts = %Options{format: :svg, width: w, height: h, error_correction: ec}
    svg_nif(data, opts)
  end

  def generate(data, f, w, h, ec) when f in ~w(png64 jpg64 jpeg64)a do
    opts = %Options{format: f, width: w, height: h, error_correction: ec}
    image_base64_nif(data, opts)
  end

  def generate(data, f, w, h, ec) when f in ~w(png jpg jpeg)a do
    opts = %Options{format: f, width: w, height: h, error_correction: ec}
    image_binary_nif(data, opts)
  end

  @doc false
  def svg_nif(_data, _opts), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def image_binary_nif(_data, _opts), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def image_base64_nif(_data, _opts), do: :erlang.nif_error(:nif_not_loaded)
end
