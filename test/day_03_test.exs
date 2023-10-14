defmodule Day03Test do
  use ExUnit.Case, async: true

  test "get coords from the input" do
    coords = Day03.get_coords("#1 @ 429,177: 12x27")
    assert coords == {429, 177}
  end

  test "get dimensions from the input" do
    dimensions = Day03.get_dimensions("#1 @ 429,177: 12x27")
    assert dimensions == {12, 27}
  end

  test "solves a" do
    assert Day03.solve_a() == 101_469
  end

  test "solves b" do
    assert Day03.solve_b() == 1067
  end
end
