defmodule Day02Test do
  use ExUnit.Case

  test "solves a" do
    assert Day02.solve_a() == 6000
  end

  test "solves b" do
    assert Day02.solve_b() == 341
  end
end
