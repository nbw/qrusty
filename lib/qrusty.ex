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

  ### Options
  - *width*: width in pixels (default: 200)
  - *height*: height in pixels (default: 200)
  - *size*: shorthand for width and height (default: 200)
  - *ec*: [error correction level](https://docs.rs/qrcode/0.6.0/qrcode/types/enum.EcLevel.html#variants) `:l`, `:m`, `:q`, `:h` (default: :m)

  ### SVG

  ```elixir
  > {:ok, %Qrusty.QR{encoded_data: svg}} = Qrusty.qr("https://elixir-lang.org/", :svg, size: 200, ec: :h)

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

  | Format | Sample                            |
  | ------ | --------------------------------- |
  | SVG    | ![ svg ](assets/qr.svg)           |
  | PNG    | ![ png ](assets/qr.png)           |
  | JPG    | ![ jpg ](assets/qr.jpg)           |
  | PNG64  | [ sample ](assets/base64.html)    |
  | JPG64  | --                                |

  Error correction:

  | L                          | M                          | Q                          | H                          |
  | -------------------------- |--------------------------- | -------------------------- | -------------------------- |
  | ![ l ](assets/qr_ec_l.jpg) | ![ m ](assets/qr_ec_m.jpg) | ![ q ](assets/qr_ec_q.jpg) | ![ h ](assets/qr_ec_h.jpg) |
  """

  alias Qrusty.QR

  @default_size 200
  @default_ec :m

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

  defmodule Error do
    defexception message: "a error has occured"

    @impl true
    def exception(reason) when is_atom(reason), do: exception(Atom.to_string(reason))
    def exception(reason), do: %__MODULE__{message: reason}
  end

  @doc """
  Generate a QR code.

  ## Example
      iex>  Qrusty.qr("https://elixir-lang.org/", :svg, size: 100);
      {:ok, %QR{}}

      iex>  Qrusty.qr("https://elixir-lang.org/", :png, width: 100, height: 100);
      {:ok, %QR{}}
  """
  @spec qr(data, format, opts) :: {:ok, %QR{}} | {:error, any()}
  def qr(data, format, opts \\ []) do
    QR.new(data, format, width(opts), height(opts), error_correction(opts))
  end

  @doc """
  Generate a QR code.

  ## Example
      iex>  Qrusty.qr!("https://elixir-lang.org/", :svg, size: 100);
      "..."

      Raises `Qrusty.Error` if the input is invalid

  """
  @spec qr!(data, format, opts) :: binary()
  def qr!(data, format, opts \\ []) do
    QR.new(data, format, width(opts), height(opts), error_correction(opts))
    |> case do
      {:ok, %{encoded_data: qr}} -> qr
      {:error, reason} -> raise Error, reason
    end
  end

  defp width(opts) do
    get(opts, :width) || get(opts, :size, @default_size)
  end

  defp height(opts) do
    get(opts, :height) || get(opts, :size, @default_size)
  end

  defp error_correction(opts), do: get(opts, :ec, @default_ec)
end
