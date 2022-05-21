defmodule QrustyTest do
  use ExUnit.Case

  alias Qrusty.QR

  @valid_input "https://elixir-lang.org/"

  describe "qr/3" do
    test "default size 200" do
      assert {:ok, %QR{width: 200, height: 200}} = Qrusty.qr(@valid_input, :svg)
    end

    test "width" do
      assert {:ok, %QR{width: 100, height: 200}} = Qrusty.qr(@valid_input, :svg, width: 100)
    end

    test "height" do
      assert {:ok, %QR{width: 200, height: 100}} = Qrusty.qr(@valid_input, :svg, height: 100)
    end

    test "size" do
      assert {:ok, %QR{width: 100, height: 100}} = Qrusty.qr(@valid_input, :svg, size: 100)
    end
  end
end
