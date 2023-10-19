defmodule Day09Test do
  use ExUnit.Case, async: true

  test "solves a" do
    assert Day09.solve_a() == 8317
  end

  test "solves b" do
    assert Day09.solve_b() == 1
  end
end
