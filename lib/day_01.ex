defmodule Day01 do
  def get_numbers(stream) do
    stream
    |> Stream.map(&ParseHelper.try_parse/1)
  end

  def solve_a do
    FileHelper.read_file(1)
    |> get_numbers
    |> Enum.sum()
  end

  def sum_until_first_duplicate(x, acc) do
    {frequency, set} = acc
    if MapSet.member?(set, frequency) do
      {:halt, frequency}
    else
      {:cont, {frequency + x, MapSet.put(set, frequency) }}
    end
  end

  def solve_b do
    FileHelper.read_file(1)
    |> get_numbers
    |> Stream.cycle()
    |> Enum.reduce_while({0, MapSet.new()}, &sum_until_first_duplicate/2)
  end
end
