defmodule Day09Test do
  use ExUnit.Case, async: true

  test "solves a" do
    assert Day09.solve_a() == 383_475
  end

  # Sadly this takes too long :/ roughly 16 seconds
  @tag :skip
  test "solves b" do
    assert Day09.solve_b() == 3_148_209_772
  end
end
