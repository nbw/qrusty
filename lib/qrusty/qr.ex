defmodule Qrusty.QR do
  @moduledoc """
  QR struct for:

  * validating input
  * catalogging input
  * generating an encoded QR
  """

  alias Qrusty.Native

  @formats ~w(svg png jpg jpeg png64 jpeg64 jpg64)a

  defstruct data: nil,
            encoded_data: nil,
            format: nil,
            height: nil,
            width: nil

  @type t :: %__MODULE__{
          data: binary(),
          encoded_data: binary() | String.t(),
          format: atom(),
          height: integer(),
          width: integer()
        }

  @doc """
  Validates input arguements and generates a QR if valid.
  """
  @spec new(data :: binary(), format :: atom(), width :: integer(), height: integer()) ::
          {:ok, %__MODULE__{}}
          | {:error, :invalid_dimensions}
          | {:error, :invalid_format}
          | {:error, :invalid_data}
  def new(data, format, width, height) do
    with :ok <- validate_data(data),
         :ok <- validate_format(format),
         :ok <- validate_dimension(width),
         :ok <- validate_dimension(height),
         {:ok, encoded_data} <- Native.generate(data, format, width, height) do
      {:ok,
       %__MODULE__{
         data: data,
         encoded_data: encoded_data,
         format: format,
         height: height,
         width: width
       }}
    end
  end

  defp validate_dimension(d) when is_integer(d) and d > 0, do: :ok
  defp validate_dimension(_d), do: {:error, :invalid_dimensions}

  defp validate_format(f) when f in @formats, do: :ok
  defp validate_format(_f), do: {:error, :invalid_format}

  defp validate_data(d) when is_binary(d), do: :ok
  defp validate_data(_d), do: {:error, :invalid_data}
end
