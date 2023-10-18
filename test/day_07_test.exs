defmodule Day07Test do
  use ExUnit.Case, async: true

  test "solves a" do
    assert Day07.solve_a() == "EUGJKYFQSCLTWXNIZMAPVORDBH"
  end

  test "solves b" do
    assert Day07.solve_b() == 1014
  end
end
