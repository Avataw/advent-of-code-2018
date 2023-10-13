defmodule Day02 do
  def has_occurence_of?(enum, num), do: Enum.any?(enum, fn {_, value} -> value == num end)

  def count_occurences_of(enum, num), do: Enum.count(enum, &has_occurence_of?(&1, num))

  def solve_a do
    all_occs =
      FileHelper.read_as_lines(2)
      |> Stream.map(&StringHelper.count_letters/1)

    count_occurences_of(all_occs, 2) * count_occurences_of(all_occs, 3)
  end

  def solve_b do
    strings =
      FileHelper.read_as_lines(2)
      |> Stream.map(&String.graphemes/1)

    Enum.find_value(strings, fn first_string ->
      Enum.find_value(strings, fn second_string ->
        if EnumHelper.count_diffs(first_string, second_string) == 1 do
          EnumHelper.merge_overlap(first_string, second_string)
        end
      end)
    end)
    |> Enum.join()
  end
end
