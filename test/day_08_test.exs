defmodule Day08Test do
  use ExUnit.Case, async: true

  test "solves a" do
    assert Day08.solve_a() == 42196
  end

  test "solves b" do
    assert Day08.solve_b() == 33649
  end
end
