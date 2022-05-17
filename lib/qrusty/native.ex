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

  @doc false
  def generate(data, :svg, w, h), do: svg_nif(data, w, h)

  def generate(data, :png, w, h), do: png_nif(data, w, h)

  def generate(data, :png64, w, h), do: png64_nif(data, w, h)

  def generate(data, f, w, h) when f in ~w(jpg jpeg)a, do: jpg_nif(data, w, h)

  def generate(data, f, w, h) when f in ~w(jpg64 jpeg64)a, do: jpg64_nif(data, w, h)

  @doc false
  def svg_nif(_data, _w, _h), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def png_nif(_data, _w, _h), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def png64_nif(_data, _w, _h), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def jpg_nif(_data, _w, _h), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def jpg64_nif(_data, _width, _height), do: :erlang.nif_error(:nif_not_loaded)
end
