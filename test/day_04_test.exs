defmodule Day04Test do
  use ExUnit.Case, async: true

  test "get's date time" do
    date = Day04.parse_date_time("[1518-11-01 00:23]")
    assert date == ~U[1518-11-01 00:23:00Z]
  end

  test "get's time" do
    time = Day04.parse_time("[1518-11-01 00:23]")
    assert time == 23
  end

  test "get guard Id" do
    guard_id = Day04.parse_guard_id("Guard #10 begins shift")
    assert guard_id == 10
  end

  test "solves a" do
    assert Day04.solve_a() == 73646
  end

  test "solves b" do
    assert Day04.solve_b() == 4727
  end
end
