defmodule Qrusty.NativeTest do
  use ExUnit.Case

  alias Qrusty.Native

  @valid_input "https://elixir-lang.org/"

  describe "generate/3" do
    test "svg" do
      assert {:ok, svg} = Native.generate(@valid_input, :svg, 200, 200)
      assert svg == load_asset("qr.svg")
    end

    test "png" do
      assert {:ok, binary} = Native.generate(@valid_input, :png, 200, 200)
      assert binary == load_asset("qr.png")
    end

    test "jpg/jpeg" do
      jpg_asset = load_asset("qr.jpg")

      assert {:ok, binary} = Native.generate(@valid_input, :jpg, 200, 200)
      assert binary == jpg_asset

      assert {:ok, binary} = Native.generate(@valid_input, :jpeg, 200, 200)
      assert binary == jpg_asset
    end

    test "jpg64/jpeg64" do
      jpg_asset = load_asset("qr_jpg64.txt")

      assert {:ok, binary64} = Native.generate(@valid_input, :jpg64, 200, 200)
      assert binary64 == jpg_asset

      assert {:ok, binary64} = Native.generate(@valid_input, :jpeg64, 200, 200)
      assert binary64 == jpg_asset
    end

    test "png64" do
      assert {:ok, binary64} = Native.generate(@valid_input, :png64, 200, 200)
      assert binary64 == load_asset("qr_png64.txt")
    end
  end

  def load_asset(filename), do: File.read!("./test/assets/#{filename}")
end
