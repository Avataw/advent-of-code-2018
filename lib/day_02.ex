defmodule Day02 do
  def has_occurence_of?(enum, num) do
    enum
    |> Enum.any?(fn {_, value} -> value == num end)
  end

  def count_occurences_of(map, num) do
    map
    |> Stream.map(&has_occurence_of?(&1, num))
    |> Enum.count(&(&1 == true))
  end

  def solve_a do
    all_occs =
      FileHelper.read_file(2)
      |> Stream.map(&StringHelper.count_letters/1)

    twos = count_occurences_of(all_occs, 2)
    threes = count_occurences_of(all_occs, 3)

    twos * threes
  end

  def solve_b do
    all_ocs =
      FileHelper.read_file(2)
      |> Stream.map(&StringHelper.count_letters/1)
      |> Stream.filter(fn x -> has_occurence_of?(x, 2) || has_occurence_of?(x, 3) end)

    all_ocs
  end
end
