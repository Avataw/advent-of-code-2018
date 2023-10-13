defmodule Day01Test do
  use ExUnit.Case, async: true

  test "solves a" do
    assert Day01.solve_a() == 427
  end

  test "solves b" do
    assert Day01.solve_b() == 341
  end
end
