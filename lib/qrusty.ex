defmodule Qrusty do
  @moduledoc """
  Documentation for `Qrusty`

  QR Code generator that leverages [precompiled Rust](https://github.com/philss/rustler_precompiled).

  The "precompiled" implies that using this library does not require installing Rust.

  ## Usage

  The following QR formats are supported:

  - SVG (`:svg`)
  - PNG (`:png`)
  - JPG (`:jpg`)
  - base64 PNG (`:png64`)
  - base64 JPG (`:jpg64`)

  ### SVG

  ```elixir
  > {:ok, %Qrusty.QR{encoded_data: svg}} = Qrusty.qr("https://elixir-lang.org/", :svg, size: 200)

  File.write("./assets/qr.svg", svg)
  ```

  ### PNG/JPG

  ```elixir
  > {:ok, %Qrusty.QR{encoded_data: binary}} = Qrusty.qr("https://elixir-lang.org/", :png, width: 200, height: 200)

  File.write("./assets/qr.png", binary)

  > {:ok, %Qrusty.QR{encoded_data: binary}} = Qrusty.qr("https://elixir-lang.org/", :jpg, size: 200)

  File.write("./assets/qr.jpg", binary)
  ```

  ### Base64 PNG/JPG

  ```elixir
  # :png64 or :jpg64
  > {:ok, %Qrusty.QR{encoded_data: binary_64}} = Qrusty.qr("https://elixir-lang.org/", :png64, width: 200, height: 200)

  # Heex Template (for example)
  <a href={"data:image/png;base64, " <> binary_64} download="qr.png">
    <img src={"data:image/png;base64, "<> binary_64}></img>
  </a>
  ```

  | Format | Sample                                                                  |
  | ------ | ----------------------------------------------------------------------- |
  | SVG    | ![ svg ](assets/qr.svg)                                              |
  | PNG    | ![ png ](assets/qr.png)                                              |
  | JPG    | ![ jpg ](assets/qr.jpg)                                              |
  | PNG64  | [ sample ](assets/base64.html) |
  | JPG64  | --                                                                      |
  """

  alias Qrusty.QR

  @default_size 200

  import Keyword, only: [get: 2, get: 3]

  @type data :: String.t()
  @type format :: :svg | :png | :jpg | :jpeg | :png64 | :jpg64 | :jpeg64
  @type opts ::
          [
            size: integer(),
            height: integer(),
            width: integer()
          ]
          | []

  @doc """
  Generate a QR code.

  ## Example
      iex>  Qrusty.qr("https://elixir-lang.org/", size: 100);
      {:ok, %QR{}}

      iex>  Qrusty.qr("https://elixir-lang.org/", width: 100, height: 100);
      {:ok, %QR{}}
  """
  @spec qr(data, format, opts) :: {:ok, %QR{}} | {:error, any()}
  def qr(data, format, opts \\ []) do
    QR.new(data, format, width(opts), height(opts))
  end

  defp width(opts) do
    get(opts, :width) || get(opts, :size, @default_size)
  end

  defp height(opts) do
    get(opts, :height) || get(opts, :size, @default_size)
  end
end
