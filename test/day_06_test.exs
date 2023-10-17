defmodule Day06Test do
  use ExUnit.Case, async: true

  test "solves a" do
    assert Day06.solve_a() == 5429
  end

  test "solves b" do
    assert Day06.solve_b() == 32614
  end
end
