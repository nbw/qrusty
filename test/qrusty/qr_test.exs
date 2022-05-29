defmodule Qrusty.QrTest do
  use ExUnit.Case

  alias Qrusty.QR

  @valid_input "https://elixir-lang.org/"
  @valid_size 100
  @valid_ec :m

  describe "new/3" do
    test "valid dimensions" do
      assert {:ok, %QR{}} = QR.new(@valid_input, :svg, @valid_size, @valid_size, @valid_ec)
      assert {:error, :invalid_dimensions} == QR.new(@valid_input, :svg, -100, 0, @valid_ec)
    end

    test "valid format" do
      Enum.each(~w(svg png jpg jpeg png64 jpeg64 jpg64)a, fn format ->
        assert {:ok, %QR{}} = QR.new(@valid_input, format, @valid_size, @valid_size, @valid_ec)
      end)

      assert {:error, :invalid_format} =
               QR.new(@valid_input, :mp3, @valid_size, @valid_size, @valid_ec)
    end

    test "valid data" do
      assert {:ok, %QR{}} = QR.new(@valid_input, :svg, @valid_size, @valid_size, @valid_ec)

      assert {:error, :invalid_data} ==
               QR.new(%{hello: "世界"}, :svg, @valid_size, @valid_size, @valid_ec)
    end

    test "valid error correction" do
      assert {:ok, %QR{}} = QR.new(@valid_input, :svg, @valid_size, @valid_size, :l)
      assert {:ok, %QR{}} = QR.new(@valid_input, :svg, @valid_size, @valid_size, :m)
      assert {:ok, %QR{}} = QR.new(@valid_input, :svg, @valid_size, @valid_size, :q)
      assert {:ok, %QR{}} = QR.new(@valid_input, :svg, @valid_size, @valid_size, :h)

      assert {:error, :invalid_error_correction} ==
               QR.new(@valid_input, :svg, @valid_size, @valid_size, :x)
    end
  end
end
