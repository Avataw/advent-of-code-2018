defmodule Day05 do
  def has_reaction?(first_string, second_string) do
    String.downcase(first_string) == String.downcase(second_string) and
      first_string != second_string
  end

  def solve(input) do
    input
    |> String.graphemes()
    |> Enum.reduce([], fn char, acc ->
      cond do
        Enum.empty?(acc) -> [char]
        has_reaction?(char, hd(acc)) -> tl(acc)
        true -> [char | acc]
      end
    end)
    |> Enum.count()
  end

  def solve_a do
    FileHelper.read_as_lines(5)
    |> Enum.take(1)
    |> hd
    |> solve
  end

  def solve_b do
    input = FileHelper.read_as_word(5)

    StringHelper.alphabetize()
    |> Enum.map(fn letter ->
      input
      |> String.replace(letter, "")
      |> String.replace(String.upcase(letter), "")
      |> solve()
    end)
    |> Enum.min()
  end
end
