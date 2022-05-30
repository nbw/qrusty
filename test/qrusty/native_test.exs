defmodule Qrusty.NativeTest do
  use ExUnit.Case

  alias Qrusty.Native

  @valid_input "https://elixir-lang.org/"
  @valid_size 200
  @valid_ec :m

  describe "generate/3" do
    test "svg" do
      assert {:ok, svg} = Native.generate(@valid_input, :svg, @valid_size, @valid_size, @valid_ec)
      assert svg == load_asset("qr.svg")
    end

    test "png" do
      assert {:ok, binary} =
               Native.generate(@valid_input, :png, @valid_size, @valid_size, @valid_ec)

      assert binary == load_asset("qr.png")
    end

    test "jpg/jpeg" do
      jpg_asset = load_asset("qr.jpg")

      assert {:ok, binary} =
               Native.generate(@valid_input, :jpg, @valid_size, @valid_size, @valid_ec)

      assert binary == jpg_asset

      assert {:ok, binary} =
               Native.generate(@valid_input, :jpeg, @valid_size, @valid_size, @valid_ec)

      assert binary == jpg_asset
    end

    test "jpg64/jpeg64" do
      jpg_asset = load_asset("qr_jpg64.txt")

      assert {:ok, binary64} =
               Native.generate(@valid_input, :jpg64, @valid_size, @valid_size, @valid_ec)

      assert binary64 == jpg_asset

      assert {:ok, binary64} =
               Native.generate(@valid_input, :jpeg64, @valid_size, @valid_size, @valid_ec)

      assert binary64 == jpg_asset
    end

    test "png64" do
      assert {:ok, binary64} =
               Native.generate(@valid_input, :png64, @valid_size, @valid_size, @valid_ec)

      assert binary64 == load_asset("qr_png64.txt")
    end
  end

  def load_asset(filename), do: File.read!("./test/assets/#{filename}")
end
