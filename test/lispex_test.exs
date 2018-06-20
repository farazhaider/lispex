defmodule LispexTest do
  use ExUnit.Case
  doctest Lispex

  test "greets the world" do
    assert Lispex.hello() == :world
  end
end
