defmodule Qrusty do
  @moduledoc """
  Documentation for `Qrusty`
  """

  alias Qrusty.QR

  @default_size 200

  import Keyword, only: [get: 2, get: 3]

  @type data :: String.t()
  @type format :: :svg | :png | :jpg | :jpeg | :png64 | :jpg64 | :jpeg64
  @type opts :: %{
          optional(:size) => integer(),
          optional(:height) => integer(),
          optional(:width) => integer()
        }

  @doc """
  Generate a QR code.

  ## Example
      iex>  Qrusty.qr("https://elixir-lang.org/", size: 100);
      {:ok, %QR{}}

      iex>  Qrusty.qr("https://elixir-lang.org/", width: 100, height: 100);
      {:ok, %QR{}}
  """
  @spec qr(data, format, opts) :: {:ok, %QR{}} | {:error, any()}
  def qr(data, format, opts) do
    QR.new(data, format, width(opts), height(opts))
  end

  defp width(opts) do
    get(opts, :width) || get(opts, :size, @default_size)
  end

  defp height(opts) do
    get(opts, :height) || get(opts, :size, @default_size)
  end
end
