defmodule Day05Test do
  use ExUnit.Case, async: true

  test "has reaction" do
    assert Day05.has_reaction?("a", "a") == false
    assert Day05.has_reaction?("A", "A") == false
    assert Day05.has_reaction?("a", "A") == true
    assert Day05.has_reaction?("A", "a") == true
  end

  test "solve" do
    assert Day05.solve("dabAcCaCBAcCcaDA") == 10
  end

  test "solves a" do
    assert Day05.solve_a() == 9526
  end

  test "solves b" do
    assert Day05.solve_b() == 6694
  end
end
