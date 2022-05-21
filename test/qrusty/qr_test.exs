defmodule Qrusty.QrTest do
  use ExUnit.Case

  alias Qrusty.QR

  @valid_input "https://elixir-lang.org/"

  describe "new/3" do
    test "valid dimensions" do
      assert {:ok, %QR{}} = QR.new(@valid_input, :svg, 100, 100)
      assert {:error, :invalid_dimensions} == QR.new(@valid_input, :svg, -100, 0)
    end

    test "valid format" do
      Enum.each(~w(svg png jpg jpeg png64 jpeg64 jpg64)a, fn format ->
        assert {:ok, %QR{}} = QR.new(@valid_input, format, 100, 100)
      end)

      assert {:error, :invalid_format} = QR.new(@valid_input, :mp3, 101, 100)
    end

    test "valid data" do
      assert {:ok, %QR{}} = QR.new(@valid_input, :svg, 100, 100)
      assert {:error, :invalid_data} == QR.new(%{hello: "世界"}, :svg, 100, 100)
    end
  end
end
