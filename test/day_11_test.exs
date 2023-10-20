defmodule Day11Test do
  use ExUnit.Case, async: true

  test "individual fuel cell" do
    assert FuelCell.new(3, 5, 8).power == 4
    assert FuelCell.new(122, 79, 57).power == -5
    assert FuelCell.new(217, 196, 39).power == 0
    assert FuelCell.new(101, 153, 71).power == 4
  end

  test "first test" do
    assert Day11.solve_a(18) == %Position{x: 33, y: 45}
  end

  test "second test" do
    assert Day11.solve_a(42) == %Position{x: 21, y: 61}
  end

  test "solves a" do
    assert Day11.solve_a(9110) == %Position{x: 21, y: 13}
  end

  test "solves b" do
    assert Day11.solve_b() == 1
  end
end
