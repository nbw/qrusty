defmodule QrustyTest do
  use ExUnit.Case
  doctest Qrusty

  test "greets the world" do
    assert Qrusty.hello() == :world
  end
end
